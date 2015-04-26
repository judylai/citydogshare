class EditEventLocationAndDescription < ActiveRecord::Migration
  def change
    add_column :events, :description, :string
    change_column :events, :my_location, :string
  end
end