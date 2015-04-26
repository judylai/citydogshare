class AddTokenToDog < ActiveRecord::Migration
  def change
    add_column :dogs, :token, :string
  end
end
