class DogsController < ApplicationController

  def index

    @dogs = Dog.where(gender: ["Male", "Female"])

    ## Genders
    @all_genders = ['Male', 'Female']
    if params[:gender]
      @selected_genders = params[:gender].keys()
    else
      @selected_genders = 'all genders'
    end
    
    if @selected_genders != 'all genders'
      @dogs = @dogs.where(gender: @selected_genders)
    end
 
    ## Personalities
    @all_personalities = Personality.pluck('DISTINCT name')
    if params[:personality]
      @selected_personalities = params[:personality].keys()
    else
      @selected_personalities = ['all personalities']
    end
    
    ## Mixes 
    @all_mixes = ['All Mixes'] +  Mix.pluck('name')
    if params[:mix_id]
      @mix = params[:mix_id]
    else
      @mix = 'All Mixes'
    end
  end

end
