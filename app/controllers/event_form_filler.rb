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
    @dogs = info['dogs'] ? info['dogs'].keys : []


    @values[:start_date] = get_date(info["date_timepicker"]["start"])
    @values[:end_date] = get_date(info["date_timepicker"]["end"])
    @values[:time_of_day] = info["times"] ? info["times"].keys : []
    @values[:description] = info['description']
    @values[:my_location] = info['my_location']

    ## Return hash with new event values to create new event/update existing event
    @values
  end

  def dog_view_update(dog)
    ## Fills edit form with dog's current values
    @dog = Dog.find(dog)
    @values[:like] = @dog.readable_likes
    @values[:personality] = @dog.readable_personalities
    @values[:size] = @dog.size_id
    @values[:energy_level] = @dog.energy_level_id
    @values[:mix] = @dog.mixes.pluck(:value)

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