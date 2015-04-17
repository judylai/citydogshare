class EventsController < ApplicationController
  before_filter :current_user

  def index
    @events = []
    @dogs = current_user.dogs
    @dogs.each do |dog|
      (@events << dog.events).flatten!
    end
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render :json => @events }
    # end
  end

  def show
    id = params[:id]
    @event = Event.find(id)
    respond_to do |format|
      format.json { render :json => @event }
    end
  end

  def new
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @checked_times = []
    @dogs = current_user.dogs.pluck(:name)
    @checked_dogs = []
  end

  def create
    @dogs = get_dogs(params)
    set_flash
    if flash[:notice]
      set_vars_for_render
      render 'new'
    else
      redirect_to events_path
    end
  end


  def edit
   # @event = Event.find(params[:id])
   # @dog = @event.dog_id
  end

  def update

  end

  def destroy

  end

  def set_flash
    if not create_events
      flash[:notice] = @event.errors.messages
    elsif @dogs.empty?
      flash[:notice] = {:name => ["Please select a dog to share"]}
    end
  end


  def create_events
    @dogs.each do |dog|
      event_attr = attributes_list(params)
      event_attr[:dog] = dog
      @event = Event.new(event_attr)
      if not @event.valid?
        return false
      else
        @event.save
      end
    end
  end


  def set_vars_for_render
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
    @dogs = current_user.dogs.pluck(:name)
    @checked_times = params['times'] ? params["times"].keys : []
    @checked_dogs = params['dogs'] ? params['dogs'].keys : []
  end

  def get_dogs(params)
    dog_array = params['dogs'] ? params['dogs'].keys : []
    dog_array.map{ |dog| Dog.find_by_name(dog) }
  end

  def get_date(date_string)
    if date_string != ""
      DateTime.strptime(date_string, "%Y/%m/%d")
    else
      ""
    end
  end

  def attributes_list(params)
    event_params = {
      :start_date => get_date(params["date_timepicker"]["start"]),
      :end_date => get_date(params["date_timepicker"]["end"]),
      :time_of_day => params["times"] ? params["times"].keys : [],
      :my_location => params['location']
    }
  end

end

