class DogsController < ApplicationController

  def index

    @dogs = Dog.all()
    filter_by_gender()
    filter_by_personality()
    filter_by_size()
    filter_by_mix()
    filter_by_energy()
    filter_by_likes()

  end
  
def filter_by_energy
    @all_energies = EnergyLevel.pluck('DISTINCT level')
    if params[:energy]
      @selected_energies = params[:energy].keys()
    else
      @selected_energies = 'all energies'
    end

    if @selected_energies != 'all energies'
      @dogs = @dogs.select {|dog| @selected_energies.include? EnergyLevel.find(dog.energy_level_id).level}
    end
  end
  
  def filter_by_likes
    @all_likes = Like.pluck('DISTINCT thing')
    if params[:like]
      @selected_likes = params[:like].keys()
    else
      @selected_likes= 'all likes'
    end

    if @selected_likes != 'all likes'
      @dogs = @dogs.select do |dog|
        dog_likes = dog.likes.map { |p| p.thing} 
        (dog_likes - @selected_likes).length < dog_likes.length
      end
    end
  end

  def filter_by_personality
    @all_personalities = Personality.pluck('DISTINCT name')
    if params[:personality]
      @selected_personalities = params[:personality].keys()
    else
      @selected_personalities = 'all personalities'
    end

    if @selected_personalities != 'all personalities'
      @dogs = @dogs.select do |dog|
        dog_personalities = dog.personalities.map { |p| p.name } 
        (dog_personalities - @selected_personalities).length < dog_personalities.length 
      end
    end
  end

  def filter_by_size
    @all_sizes= Size.pluck('DISTINCT range')
    if params[:size]
      @selected_sizes= params[:size].keys()
    else
      @selected_sizes= 'all sizes'
    end

    if @selected_sizes != 'all sizes'
      @dogs = @dogs.select {|dog| @selected_sizes.include? Size.find(dog.size_id.to_i).range}
    end
  end

  def filter_by_mix
    @all_mixes = ['All Mixes'] +  Mix.pluck('DISTINCT name')
    if params[:mix_id]
      @mix = params[:mix_id]
    else
      @mix = 'All Mixes'
    end

    if @mix != 'All Mixes'
      @dogs = @dogs.select do |dog|
        dog_mixes = dog.mixes.map {|m| m.name}
        dog_mixes.include? @mix
      end
    end
  end

  def filter_by_gender
    @all_genders = ['Male', 'Female']
    if params[:gender]
      @selected_genders = params[:gender].keys()
    else
      @selected_genders = 'all genders'
    end
    
    if @selected_genders != 'all genders'
      @dogs = @dogs.select {|dog| @selected_genders.include? dog.gender}
    end
  end

end
