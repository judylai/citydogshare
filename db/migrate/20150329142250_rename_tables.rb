class RenameTables < ActiveRecord::Migration
  def change
  	rename_table :energy_level, :energy_levels
  	rename_table :personality, :personalities
  end
end