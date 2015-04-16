class EventsController < ApplicationController
  before_filter :current_user

  def index

  end

  def new
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @checked_times = []
  end

  def create

  end

  def edit
    @event = Event.find(params[:id])
    @dog = @event.dog_id
  end

  def update

  end

  def destroy

  end

end