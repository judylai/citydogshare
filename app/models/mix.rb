class Mix < ActiveRecord::Base
  attr_accessible :name
  has_many :dog_mix_linkers
  has_many :dogs, :through => :dog_mix_linkers
end