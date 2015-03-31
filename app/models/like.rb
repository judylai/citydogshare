class Like < ActiveRecord::Base
  attr_accessible :thing
  belongs_to :dog
end