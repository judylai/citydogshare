class MixesController < ApplicationController

  def autocomplete
    mixes = Mix.autocomplete_data(params[:q]) 
    respond_to do |format|
      format.json { render :json => mixes }
    end
  end

end