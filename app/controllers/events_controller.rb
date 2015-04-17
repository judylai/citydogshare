class EventsController < ApplicationController
  before_filter :current_user

  def index

  end

  def new
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @checked_times = []
    @dogs = current_user.dogs.pluck(:name)
    @checked_dogs = []
  end

  def create
    @dogs = get_dogs(params)
    @dogs.each do |dog|
      event_attr = attributes_list(params)
      event_attr[:dog] = dog
      event = Event.new(event_attr)

      if not event.valid?
        set_vars_for_render
        flash[:notice] = event.errors.messages
        render 'new' and return
      else
        event.save
      end
    end
    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
    @dog = @event.dog_id
  end

  def update

  end

  def destroy

  end

  def set_vars_for_render
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @dogs = current_user.dogs.pluck(:name)
    @checked_times = params["event"]["times"] ? params["event"]["times"].keys : []
    @checked_dogs = params['event']['dogs'] ? params['event']['dogs'].keys : []
  end

  def get_dogs(params)
    dog_array = params['event']['dogs'] ? params['event']['dogs'].keys : []
    dog_array.map{ |dog| Dog.find_by_name(dog) }
  end

  def attributes_list(params)
    event_params = {
      :start_date => params["date_timepicker"]["end"] != "" ? DateTime.strptime(params["date_timepicker"]["start"], "%Y/%m/%d") : "",
      :end_date => params["date_timepicker"]["end"] != "" ? DateTime.strptime(params["date_timepicker"]["end"], "%Y/%m/%d") : "",
      :time_of_day => params["event"]["times"] ? params["event"]["times"].keys : [],
      :my_location => params['location']
    }
  end

end

