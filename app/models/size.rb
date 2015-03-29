class Size < ActiveRecord::Base
  attr_accessible :range
  belongs_to :dog
end