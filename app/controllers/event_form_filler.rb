class EventViewHelper

  attr_accessor :dogs, :values, :all_dogs, :times, :places

  def initialize(current_user)
    @all_dogs = current_user.dogs.pluck(:name)
    @times = ["Morning", "Afternoon", "Evening", "Overnight"]
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
    @dogs = get_dogs(info)
    @values[:start_date] = get_date(info["date_timepicker"]["start"])
    @values[:end_date] = get_date(info["date_timepicker"]["end"])
    @values[:time_of_day] = info["times"] ? info["times"].keys : []
    @values[:description] = info['description']
    @values[:my_location] = info['my_location']

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

  def get_dogs(params)
    dog_array = params['dogs'] ? params['dogs'].keys : []
    dog_array.map{ |dog| Dog.find_by_name(dog) }
  end

  def date_string(date)
    if date == ""
      return date
    else
      date.strftime("%Y/%m/%d")
    end
  end




end