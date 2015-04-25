class AddVideoToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :video, :string
  end
end
