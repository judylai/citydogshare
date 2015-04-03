class DogsController < ApplicationController

  def index

    @dogs = Dog.all()
    filter_by_gender()
    filter_by_personality()
    filter_by_size()
    filter_by_mix()
    filter_by_energy()
    filter_by_likes()
    filter_by_age()

    if @dogs.empty?
      flash[:notice] = "No Dogs Found"
    end

  end

  def filter_by_age
    @age_ranges = ["0-2 years", "2-4 years", "5-8 years", "9+ years"]
    @age_pairs = [[0, 2], [2, 4], [5, 8], [9, 30]]
    @selected_ranges = get_checkbox_selections(:age)

    unless @selected_ranges.empty?
      valid_dogs = []
      @selected_ranges.each do |i|
        valid_dogs += @dogs.select {|dog| dog.age >= @age_pairs[i.to_i][0] && dog.age <= @age_pairs[i.to_i][1]}
      end 
      @dogs = valid_dogs
    end
  end

  
  def filter_by_energy
    @all_energies = EnergyLevel.pluck('DISTINCT level')
    @selected_energies = get_checkbox_selections(:energy)

    unless @selected_energies.empty?
      @dogs = @dogs.select {|dog| @selected_energies.include? dog.energy_level}
    end
  end
  
  def filter_by_likes
    @all_likes = Like.pluck('DISTINCT thing')
    @selected_likes = get_checkbox_selections(:like)

    unless @selected_likes.empty?
      @dogs = @dogs.select do |dog|
        (dog.readable_likes - @selected_likes).length < dog.readable_likes.length
      end
    end
  end

  def filter_by_personality
    @all_personalities = Personality.pluck('DISTINCT name')
    @selected_personalities = get_checkbox_selections(:personality)

    unless @selected_personalities.empty?
      @dogs = @dogs.select do |dog|
        (dog.readable_personalities - @selected_personalities).length < dog.readable_personalities.length
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

  def get_dropdown_selection(criteria, default)
    if params[criteria]
      return params[criteria]
    else
      return default
    end
  end

end
