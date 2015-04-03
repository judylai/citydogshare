class DogsController < ApplicationController
  before_filter :current_user

  def new
    @likes = Like.pluck(:thing)
    @personalities = Personality.pluck(:name)
  end

  def create
    @dog = Dog.new(attributes_list(params))
    @dog.user_id = @current_user.id
    if @dog.save
      redirect_to user_path(@current_user)
    else
      flash[:notice] = @dog.errors.messages
      redirect_to new_dog_path
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
      params['personalities'].keys.map {|personality| Personality.find_by_type(personality)}
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
    dog_attributes = params[:dog]
    new_attrs = {:mixes => get_mix_array(params), :size => get_size_object(dog_attributes), 
      :energy_level => get_energy_object(dog_attributes), :likes => get_likes_array(params),
      :dob => get_birthday(dog_attributes), :personalities => get_personalities_array(params) }
    dog_attributes.merge(new_attrs)
  end

end


