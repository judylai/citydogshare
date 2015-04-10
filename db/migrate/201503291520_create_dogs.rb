class CreateDogs < ActiveRecord::Migration
    def change
        create_table :dogs do |t|
            t.string :name
            t.string :image
            t.datetime :dob
            t.string :description
            t.string :motto
            t.boolean :fixed
            t.string :health
            t.string :availability
            t.string :gender
            t.integer :size_id
            t.integer :energy_level_id
            t.integer :user_id
        end
        
        create_table :mixes do |t|
            t.string :value
        end
        
        create_table :likes do |t|
            t.string :value
        end
        
        create_table :personalities do |t|
            t.string :value
        end
        
        create_table :energy_levels do |t|
            t.string :value
        end
        
        create_table :sizes do |t|
            t.string :value
        end
        
        create_table :dog_like_linkers do |t|
            t.integer :dog_id
            t.integer :like_id
        end
        
        create_table :dog_mix_linkers do |t|
            t.integer :dog_id
            t.integer :mix_id
        end
        
        create_table :dog_personality_linkers do |t|
            t.integer :dog_id
            t.integer :personality_id
        end
    end
end
