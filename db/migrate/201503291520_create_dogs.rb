class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :image
      t.datetime :dob
      t.integer :weight
      t.string :description
      t.string :motto
      t.boolean :fixed
      t.string :health 
      t.string :comments
      t.string :contact
      t.string :availability

    end

    create_table :mixes do |t|
      t.string :name
    end

    create_table :likes do |t|
      t.string :thing
    end

    create_table :personality do |t|
      t.string :type
    end

    create_table :energy_level do |t|
      t.string :level
    end

  end
end


