class NewDogAssociationsTable < ActiveRecord::Migration
	def change
    create_table :dog_linker do |t|
      t.references 'dog'
      t.references 'mix'
      t.references 'like'
      t.references 'personality'
    end

    remove_column :dogs, :size
    add_column :dogs, :size_id, :references
    add_column :dogs, :energy_level_id, :references
    add_column :dogs, :user_id, :references
    remove_column :dogs, :weight
  end
end