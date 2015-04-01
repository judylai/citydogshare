class FixDogsAssociationTables < ActiveRecord::Migration
  def up
  	drop_table :dog_linker 
    
    create_table :dog_mix_linkers do |t|
      t.references 'dog'
      t.references 'mix'
    end
    create_table :dog_like_linkers do |t|
      t.references 'dog'
      t.references 'like'
    end
    create_table :dog_personality_linkers do |t|
      t.references 'dog'
      t.references 'personality'
    end
  end

  def down
  end
end
