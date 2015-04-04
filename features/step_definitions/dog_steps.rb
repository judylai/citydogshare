require 'cucumber/rspec/doubles'

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

Given /the following dogs exist/ do |dogs_table|
  dogs_table.hashes.each do |dog|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_dog = Dog.create()
    new_dog.name = dog[:name]
    new_dog.gender = dog[:gender]
    new_dog.size = Size.find_by_range(dog[:size])
    new_dog.save
  end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field, match: :first)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field, match: :first)
end

When /^I create a new dog "([^"]*)"$/ do |name|
  FactoryGirl.create(:dog)
end

And /^I push "([^"]*)"$/ do |button|
  DogsController.any_instance.should_receive(:get_mix_array).and_return([Mix.find(1)])
  click_button(button)
end
