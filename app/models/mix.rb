class Mix < ActiveRecord::Base
  attr_accessible :name
  has_many :dog_mix_linkers
  has_many :dogs, :through => :dog_mix_linkers

  def self.to_array()
  	self.select('name').all.map(&:name)
  end 

  def self.to_json_array()
  	self.select('name').to_json
  end

end