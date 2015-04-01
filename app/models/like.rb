class Like < ActiveRecord::Base
  attr_accessible :thing
  has_many :dog_like_linkers
  has_many :dogs, :through => :dog_like_linkers
end