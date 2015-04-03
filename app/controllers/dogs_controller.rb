class DogsController < ApplicationController

  def new
    #dog.mixes.append(Mix.find_by_name("Labrador"))
    @likes = Like.pluck(:thing)
  end

  def create
    #likes fucks everything up right now
    @dog = Dog.create(attributes_list(params))


    redirect_to root_path
  end

  def get_mix_array(params)
    tags = params['item']['tags']
    tags.map{ |tag| Mix.find_by_name(tag) }
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

  def get_birthday(dog_attributes)
    year = dog_attributes['dob(1i)'].to_i
    month = dog_attributes['dob(2i)'].to_i
    day = dog_attributes['dob(3i)'].to_i

    DateTime.new(year, month, day)
  end

  def attributes_list(params)
    dog_attributes = params[:dog] #some things in params have string accessors

    dog_attributes[:mixes] = get_mix_array(params) #make sure mix is not empty
    dog_attributes[:size] = get_size_object(dog_attributes)
    dog_attributes[:energy_level] = get_energy_object(dog_attributes)
    dog_attributes[:likes] = get_likes_array(params)
    dog_attributes[:dob] = get_birthday(dog_attributes)
    return dog_attributes
  end

end


