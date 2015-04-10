class Like < ActiveRecord::Base
  attr_accessible :value
  has_many :dog_like_linkers
  has_many :dogs, :through => :dog_like_linkers
end