class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.references :user
      t.references :dog

      t.timestamps
    end
    add_index :stars, :user_id
  end
end
