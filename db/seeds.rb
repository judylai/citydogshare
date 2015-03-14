# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [ {:uid => '12345', :last_name => 'Wayne', :first_name => 'Bruce', :location => 'Bat Cave, Gotham City', :gender => 'Male', :image => 'http://tinyurl.com/opnc38n', :status => 'looking',
           :phone_number => '(555)228-6261', :email => 'not_batman@wayneenterprises.com', :description => 'I love bats', :availability => 'not nights', :oauth_token => 'ABCDEF...', :oauth_expires_at => '12-Jun-1981'},
  	    ]

users.each do |user|
  User.create!(user)
end