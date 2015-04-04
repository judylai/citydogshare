class DogsController < ApplicationController

  before_filter :current_user

  def index

    @dogs = Dog.all()
    filter_by_gender()
    filter_by('personality')
    filter_by('like')
    filter_by_size()
    filter_by_mix()
    filter_by_energy()
    filter_by_age()

    @no_dogs = @dogs.empty?

  end

  def new
    @likes = Like.pluck(:thing)
    @personalities = Personality.pluck(:name)
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
    dog.age >- @age_pairs[i][0] && dog.age <= @age_pairs[i][1]
  end

  
  def filter_by_energy
    @all_energies = EnergyLevel.pluck('DISTINCT level')
    @selected_energies = get_checkbox_selections(:energy)

    unless @selected_energies.empty?
      @dogs = @dogs.select {|dog| @selected_energies.include? dog.energy_level}
    end
  end

   def filter_by(arg)
    if arg == "like"
      @all_likes = Like.pluck('DISTINCT thing')
    elsif arg == "personality"
      @all_personalities = Personality.pluck('DISTINCT name')
    end
    instance_variable_set("@" + "selected_#{arg.pluralize}", get_checkbox_selections(arg.to_sym))

    method_name = "readable_#{arg.pluralize}"
    unless instance_variable_get("@" + "selected_#{arg.pluralize}").empty?
      @dogs = @dogs.select do |dog|
        (dog.public_send(method_name) - instance_variable_get("@" + "selected_#{arg.pluralize}")).length < dog.public_send(method_name).length  if dog.respond_to? method_name
      end
    end
  end 

  def filter_by_size
    @all_sizes= Size.pluck('DISTINCT range')
    @selected_sizes = get_checkbox_selections(:size)

    unless @selected_sizes.empty?
      @dogs = @dogs.select {|dog| @selected_sizes.include? dog.size}
    end
  end

  def filter_by_mix
    @all_mixes = ['All Mixes'] +  Mix.pluck('DISTINCT name')
    @mix = get_dropdown_selection(:mix, 'All Mixes')

    unless @mix == 'All Mixes'
      @dogs = @dogs.select {|dog| dog.readable_mixes.include? @mix}
    end
  end

  def filter_by_gender
    @all_genders = ['Male', 'Female']
    @selected_genders = get_checkbox_selections(:gender)
    
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
      tags.map{ |tag| Mix.find_by_name(tag) }
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

  def get_likes_array(params)
    if params['likes'] != nil
      params['likes'].keys.map { |like| Like.find_by_thing(like) }
    else
      return []
    end
  end

  def get_personalities_array(params)
    if params['personalities'] != nil
      params['personalities'].keys.map {|personality| Personality.find_by_name(personality)}
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
      :energy_level => get_energy_object(dog_attributes), :likes => get_likes_array(params),
      :dob => get_birthday(dog_attributes), :personalities => get_personalities_array(params) }
    dog_attributes.merge(new_attrs)
  end

end

