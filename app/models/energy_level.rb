class EnergyLevel < ActiveRecord::Base
	attr_accessible :level
	has_many :dogs
end