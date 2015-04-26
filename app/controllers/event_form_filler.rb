class EventViewHelper

  attr_accessor :dogs

  def initialize(current_user)
    @dogs = current_user.dogs.length == 1 ? current_user.dogs.pluck(:name) : []
    @values = {}
    @values[:start_date] = ""
    @values[:end_date] = ""
    @values[:time_of_day] = []
    @values[:my_location] = "My House"
    @values[:description] = ""
  end

  def event_info(info)
    # Set form fields with new event info
    @values[:start_date] = get_date(info["date_timepicker"]["start"])
    @values[:end_date] = get_date(info["date_timepicker"]["end"])
    @values[:time_of_day] = info["times"] ? info["times"].keys : []
    @values[:description] = info['description']
    @values[:location] = info['location']

    ## Return hash with new event values to create new event/update existing event
    @values
  end

  def get_date(date_string)
    if date_string != ""
      DateTime.strptime(date_string, "%Y/%m/%d")
    else
      ""
    end
  end




end