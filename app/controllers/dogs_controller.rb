class DogsController < ApplicationController

  before_filter :current_user

  def index

    @dogs = Dog.all()

    filter_criteria = ['gender', 'personality', 'like', 'mix', 'size', 'energy_level', 'age']
    filter_criteria.each {|criteria| filter_by(criteria)} 

    @no_dogs = @dogs.empty?

  end

  def new
    if current_user.address != nil and current_user.address != "" and current_user.zipcode != nil and current_user.zipcode != "" 
      @likes = Like.pluck(:value)
      @personalities = Personality.pluck(:value)
    else
      flash[:notice] = "Please update your address to add a dog."
      redirect_to edit_user_path(current_user)
    end
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
      flash[:notice] = @dog.errors.messages
      redirect_to new_dog_path
    end
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


  def get_mix_array(params)
    if params['item']
      tags = params['item']['tags']
      tags.map{ |tag| Mix.find_by_value(tag) }
    else
      return []
    end
  end

  def get_size_object(dog_attributes)
    Size.find(dog_attributes['size'])
  end      

  def get_energy_object(dog_attributes)
    EnergyLevel.find(dog_attributes['energy_level'])
  end

  def get_attribute_array(params, things)
    if params[things] != nil
      if things == "likes"
        params[things].keys.map { |thing| Like.find_by_value(thing) }
      else
        params[things].keys.map { |thing| Personality.find_by_value(thing) }
      end
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
    new_attrs = {:mixes => get_mix_array(params), :size => get_size_object(dog_attributes), 
      :energy_level => get_energy_object(dog_attributes), :likes => get_attribute_array(params, 'likes'),
      :dob => get_birthday(dog_attributes), :personalities => get_attribute_array(params, 'personalities') }
    dog_attributes.merge(new_attrs)
  end

end


