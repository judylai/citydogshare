class EventsController < ApplicationController
  before_filter :current_user

  def new
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @checked_times = []
  end


  def edit
    @event = Event.find(params[:id])
    @dog = @event.dog_id
  end


  def destroy

  end

end