class Mix < ActiveRecord::Base
  attr_accessible :name
  has_many :dog_mix_linkers
  has_many :dogs, :through => :dog_mix_linkers


  def self.autocomplete(q)
    where("mixes.name LIKE :q1 OR mixes.name LIKE :q2", {:q1 => "#{q}%", :q2 => "% #{q}%"}).order('name ASC').limit(5)
  end
  
  def self.autocomplete_data(q)
    Mix.autocomplete(q).map(&:name)
  end

end