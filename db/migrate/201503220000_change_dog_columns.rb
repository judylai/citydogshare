class ChangeDogColumns < ActiveRecord::Migration    
  def change
    remove_column :dogs, :size
    add_column :dogs, :size_id, :integer
    add_column :dogs, :energy_level_id, :integer
    add_column :dogs, :user_id, :integer
    remove_column :dogs, :weight
  end
end