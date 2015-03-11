class AddFacebookInfoToUsers < ActiveRecord::Migration
	def change
		add_column :users, :last_name, :string
		add_column :users, :first_name, :string
		add_column :users, :location, :string
		add_column :users, :gender, :string
		add_column :users, :image, :string
		add_column :users, :status, :string
		add_column :users, :phone_number, :string
		add_column :users, :email, :string
		add_column :users, :description, :string
		add_column :users, :availability, :string
		remove_column :users, :provider, :string
	end
end