class EnergyLevel < ActiveRecord::Base
	attr_accessible :level
	belongs_to :dog
end