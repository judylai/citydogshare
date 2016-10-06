class EnergyLevel < ActiveRecord::Base
# 	attr_accessible :level
	has_many :dogs

    def self.all_values
      EnergyLevel.pluck('value')
    end
end