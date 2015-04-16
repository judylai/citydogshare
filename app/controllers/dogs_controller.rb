class DogsController < ApplicationController
  before_filter :current_user


  def index
    @dogs = Dog.all()
    filter_criteria = ['gender', 'personality', 'like', 'mix', 'size', 'energy_level', 'age']
    filter_criteria.each {|criteria| filter_by(criteria)} 
    @no_dogs = @dogs.empty?
  end


  def new
    set_vars
    @checked_personalities = []
    @checked_likes = []
    @size = 1
    @energy_level = 1
    @mixes = []
    @action = :create
    @method = :post
  end


  def show
    id = params[:id]
    @dog = Dog.find(id)
  end

  def create
    @dog = Dog.new(attributes_list(params))
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to user_path(current_user)
    else
      set_vars_for_render(params['dog'])
      flash[:notice] = @dog.errors.messages
      render 'new'
    end
  end

  def edit 
    if current_user.id != @dog.user_id
      flash[:notice] = "You can only edit your dog's profile"
    else
      @dog = Dog.find(params[:id])
      set_vars
      @checked_likes = @dog.readable_likes
      @checked_personalities = @dog.readable_personalities
      @size = @dog.size_id
      @energy_level = @dog.energy_level_id
      @mixes = @dog.mixes.pluck(:value)
      @action = :update
      @method = :put
    end
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update_attributes(attributes_list(params))
      redirect_to dog_path(@dog.id)
    else
      set_vars_for_render(params['dog'])
      flash[:notice] = @dog.errors.messages
      redirect_to edit_dog_path(@dog.id)
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.delete
    redirect_to user_path(@current_user)
  end

  def set_vars
    @likes = Like.pluck(:value)  
    @personalities = Personality.pluck(:value)
  end

  def set_vars_for_render(dog_attributes)
    set_vars
    @checked_personalities = dog_attributes['personalities'] ? dog_attributes['personalities'].keys  : []
    @checked_likes = dog_attributes['likes'] ? dog_attributes['likes'].keys : []
    @size = dog_attributes['size']
    @energy_level = dog_attributes['energy_level']
    @mixes = dog_attributes['mixes'].split(',')
  end

  def filter_by(model)
    unless model == "age" or model == "gender"
      instance_variable_set("@" + "all_#{model.pluralize}", model.classify.constantize.pluck('value'))
    end

    case model
    when "energy_level", "size"
        filter_single_attributes(model)
    when "like", "personality"
        filter_multiple_attributes(model)
    when "age"
        filter_by_age()
    when "mix"
        filter_by_mix()
    when "gender"
        filter_by_gender()
    end

  end

  def filter_by_age
    @age_ranges = ["0-2 years", "2-4 years", "5-8 years", "9+ years"]
    @age_pairs = [[0, 2], [2, 4], [5, 8], [9, 30]]
    @selected_ranges = get_checkbox_selections(:age)

    unless @selected_ranges.empty?
      valid_dogs = []
      @selected_ranges.each do |i|
        valid_dogs += @dogs.select {|dog| validate_dog_age?(dog, i.to_i)}
      end 
      @dogs = valid_dogs
    end
  end

  def validate_dog_age?(dog, i)
    dog.age >= @age_pairs[i][0] && dog.age <= @age_pairs[i][1]
  end


  def filter_single_attributes(model)

    selected_values = get_checkbox_selections(model)

    unless selected_values.empty?
        @dogs = @dogs.select {|dog| selected_values.include? dog.send(model)}
    end

    instance_variable_set("@" + "selected_#{model.pluralize}", selected_values)
  end

  def filter_multiple_attributes(arg)
    instance_variable_set("@" + "selected_#{arg.pluralize}", get_checkbox_selections(arg))

    method_name = "readable_#{arg.pluralize}"
    unless instance_variable_get("@" + "selected_#{arg.pluralize}").empty?
      @dogs = @dogs.select do |dog|
        (dog.public_send(method_name) - instance_variable_get("@" + "selected_#{arg.pluralize}")).length < dog.public_send(method_name).length  if dog.respond_to? method_name
      end
    end
  end 

  def filter_by_mix
    @all_mixes = ['All Mixes'] +  Mix.order(:value).pluck('value')
    @mix = get_dropdown_selection(:mix, 'All Mixes')

    unless @mix == 'All Mixes'
      @dogs = @dogs.select {|dog| dog.readable_mixes.include? @mix}
    end
  end

  def filter_by_gender
    @all_genders = ['Male', 'Female']
    @selected_genders = get_checkbox_selections('gender')
    
    unless @selected_genders.empty?
      @dogs = @dogs.select {|dog| @selected_genders.include? dog.gender}
    end
  end


  
  def get_checkbox_selections(criteria)
    if params[criteria]
      return params[criteria].keys()
    else
      return []
    end
  end


  def get_mix_array(mix_string)
    tags = mix_string.split(",")
    tags.map{ |tag| Mix.find_by_value(tag) }
  end


  def get_attribute_array(attributes, trait)
    if attributes[trait] != nil
      model_class = trait.classify.constantize
      attributes[trait].keys.map { |thing| model_class.find_by_value(thing) }
    else
      return []
    end
  end

  def get_dropdown_selection(criteria, default)
    if params[criteria]
      return params[criteria]
    else
      return default
    end
  end


  def get_birthday(dog_attributes)
    year = dog_attributes['dob(1i)'].to_i
    month = dog_attributes['dob(2i)'].to_i
    day = dog_attributes['dob(3i)'].to_i

    DateTime.new(year, month, day)
  end

  def attributes_list(params)
    dog_attributes = params["dog"]
    new_attrs = {
      :mixes => get_mix_array(dog_attributes['mixes']),
      :size => Size.find(dog_attributes['size']), 
      :energy_level => EnergyLevel.find(dog_attributes['energy_level']), 
      :likes => get_attribute_array(dog_attributes, 'likes'),
      :personalities => get_attribute_array(dog_attributes, 'personalities'),
      :dob => get_birthday(dog_attributes) }
    dog_attributes.merge(new_attrs)
  end
end


