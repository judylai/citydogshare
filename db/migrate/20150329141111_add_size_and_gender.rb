class AddSizeAndGender < ActiveRecord::Migration  
  def up
    add_column :dogs, :size, :string
    add_column :dogs, :gender, :string
  end

  def down
    remove_column :dogs, :weight
  end

end