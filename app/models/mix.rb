class Mix < ActiveRecord::Base
  attr_accessible :value
  has_many :dog_mix_linkers
  has_many :dogs, :through => :dog_mix_linkers


  def self.autocomplete(q)
    where("UPPER(mixes.value) LIKE UPPER(:q1) OR UPPER(mixes.value) LIKE UPPER(:q2)", {:q1 => "#{q}%", :q2 => "% #{q}%"}).order('value ASC').limit(5)
  end
  
  def self.autocomplete_data(q)
    Mix.autocomplete(q).map(&:value)
  end

  def self.all_values
    Mix.order(:value).pluck('Distinct value')
  end

end