class Size < ActiveRecord::Base
  attr_accessible :value
  has_many :dogs

  def self.all_values
    Size.pluck('value')
  end
end