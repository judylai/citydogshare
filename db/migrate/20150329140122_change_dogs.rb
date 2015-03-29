class ChangeDogs < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :range
    end
  end
end