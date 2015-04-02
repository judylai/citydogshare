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

  def self.autocomplete(q)
    q = "%#{q}%"
    where("mixes.name LIKE ?", q).order('name ASC').limit(5)
  end
  
  def self.autocomplete_data(q)
    Mix.autocomplete(q).map(&:name)
  end

end