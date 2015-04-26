class AddDogsTokenToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :dogs_token, :string
  end
end
