class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :time_of_day, :my_location, :dog
  belongs_to :dog

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :time_of_day, presence: true
  validates :dog, presence: true

  def color
    if dog_id % 10 == 1
      'blue'
    elsif dog_id % 10 == 2
      'orange'
    elsif dog_id % 10 == 3
      'red'
    elsif dog_id % 10 == 4
      'green'
    elsif dog_id % 10 == 5
      'purple'
    else
      'black'
    end
  end
end
