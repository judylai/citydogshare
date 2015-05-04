class EventViewHelper

  attr_accessor :dogs, :values, :all_dogs, :times, :places

  def initialize(current_user)
    @all_dogs = current_user.dogs.pluck(:name)
    @times = ["Morning", "Afternoon", "Evening", "Overnight", "(Any)"]
    @places = ["My House", "Your House", "Other"]
    @dogs = current_user.dogs.length == 1 ? @all_dogs : []
    @values = {}
    @values[:start_date] = ""
    @values[:end_date] = ""
    @values[:time_of_day] = []
    @values[:my_location] = "My House"
    @values[:description] = ""
  end

  def event_info(info)
    # Set form fields with new event info
    @dogs = info['dogs'] ? info['dogs'].keys : []

    @values[:start_date] = get_date(info["date_timepicker"]["start"])
    @values[:end_date] = get_date(info["date_timepicker"]["end"])
    @values[:time_of_day] = info["times"] ? info["times"].keys : []
    @values[:description] = info['description']
    @values[:my_location] = info['my_location']

    ## Return hash with new event values to create new event/update existing event
    @values
  end

  def event_view_update(event)
    ## Fills edit form with event's current values
    @values[:start_date] = event.start_date
    @values[:end_date] = event.end_date
    @values[:description] = event.description
    @values[:my_location] = event.my_location
    @values[:time_of_day] = event.time_of_day

  end

  def get_date(date_string)
    if date_string != ""
      DateTime.strptime(date_string, "%Y/%m/%d")
    else
      ""
    end
  end

  def date_string(date)
    if date == ""
      return ""
    else
      date.strftime("%Y/%m/%d")
    end
  end

  def start_date_string
    date_string(@values[:start_date])
  end

  def end_date_string
    date_string(@values[:end_date])
  end





end