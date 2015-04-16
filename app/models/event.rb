class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :time_of_day, :my_location
  belongs_to :dog

end
