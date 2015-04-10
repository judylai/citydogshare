class Size < ActiveRecord::Base
  attr_accessible :value
  has_many :dogs
end