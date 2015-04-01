class Size < ActiveRecord::Base
  attr_accessible :range
  has_many :dogs
end