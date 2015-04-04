class MixesController < ApplicationController

  def index
    @mixes = Mix.all
    respond_to do |format|
      format.html
      format.json {render json: @mixes}
    end
  end

  def autocomplete
    mixes = Mix.autocomplete_data(params[:q]) 
    respond_to do |format|
      format.json { render :json => mixes }
    end
  end

end