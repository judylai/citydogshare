class DogFormFiller

  attr_accessor :values, :defaults

  MIXES = Mix.all_values  
  PERSONALITIES = Personality.all_values
  LIKES = Like.all_values
  GENDERS = Dog.genders
  AGE_RANGES = Dog.age_ranges
  ENERGY_LEVELS = EnergyLevel.all_values
  SIZES = Size.all_values
  RADIUS = 100

  def initialize(current_user, request)
    @values = {}
    @values[:mix] = "All Mixes"
    @values[:personalities] = []
    @values[:likes] = []
    @values[:gender] = []
    @values[:age] = []
    @values[:energy_levels] = []
    @values[:sizes] = []
    @values[:radius] = RADIUS
    @values[:zipcode] = current_user ? current_user.zipcode : request.safe_location.postal_code

    # New Dog Form
    @values[:mixes] = []
    @values[:size] = 1
    @values[:energy_level] = 1
  end

  def update_values(selected, request, current_user)
    @values[:mix] = selected[:mix] if selected[:mix]
    @values[:personalities] = selected[:personality].keys if selected[:personality]
    @values[:likes] = selected[:like].keys if selected[:like]
    @values[:gender] = selected[:gender].keys if selected[:gender]
    @values[:energy_levels] = selected[:energy_level].keys if selected[:energy_level]
    @values[:sizes] = selected[:size].keys if selected[:size]
    @values[:age] = selected[:age].keys if selected[:age]

    if selected[:zipcode]
      @values[:zipcode] = selected[:zipcode]
    elsif current_user and current_user.zipcode
      @values[:zipcode] = current_user.zipcode
    else
      @values[:zipcode] = request.safe_location.postal_code
    end

    @values[:radius] = selected[:radius].nil? ? RADIUS : selected[:radius].to_i

  end

  def attributes_list(params)
    dog_attributes = params["dog"]
    @values[:personalities] = dog_attributes['personalities'] ? dog_attributes['personalities'].keys  : []
    @values[:likes] = dog_attributes['likes'] ? dog_attributes['likes'].keys : []
    @values[:size] = dog_attributes['size']
    @values[:energy_level] = dog_attributes['energy_level']
    @values[:mixes] = dog_attributes['mixes'].split(',')
    new_attrs = {
      :mixes => get_mix_array(dog_attributes['mixes']),
      :size => Size.find(dog_attributes['size']), 
      :energy_level => EnergyLevel.find(dog_attributes['energy_level']), 
      :likes => get_attribute_array(dog_attributes, 'likes'),
      :personalities => get_attribute_array(dog_attributes, 'personalities'),
      :dob => get_birthday(dog_attributes) }
    dog_attributes.merge(new_attrs)
  end

  def dog_view_update(dog)
    @dog = Dog.find(dog)
    @values[:likes] = @dog.readable_likes
    @values[:personalities] = @dog.readable_personalities
    @values[:size] = @dog.size_id
    @values[:energy_level] = @dog.energy_level_id
    @values[:mixes] = @dog.mixes.pluck(:value)

  end

  def get_birthday(dog_attributes)
    year = dog_attributes['dob(1i)'].to_i
    month = dog_attributes['dob(2i)'].to_i
    day = dog_attributes['dob(3i)'].to_i

    DateTime.new(year, month, day)
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



end