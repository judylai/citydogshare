

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #Movie.create([movie['title'], movie['rating'], movie['release_date']])
    new_user = Users.create(user)
    new_user.save
  end
  #flunk "Unimplemented"
end


Given /^I am logged in$/ do  
  visit "/auth/facebook"
end  


Given /^That I add Batman to the database$/ do
  	Users.
end