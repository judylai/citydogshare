class Mix < ActiveRecord::Base
  attr_accessible :name
  belongs_to :dog
end