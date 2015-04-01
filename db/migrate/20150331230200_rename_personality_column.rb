class RenamePersonalityColumn < ActiveRecord::Migration
	def change
		rename_column :personalities, :type, :name
	end
end