class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :time_of_day, :my_location, :dog
  belongs_to :dog

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :time_of_day, presence: true
  validates :dog, presence: true

end
