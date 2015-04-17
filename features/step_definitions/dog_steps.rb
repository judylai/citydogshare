require 'cucumber/rspec/doubles'

Given /^the date is "(\d\d\d\d\/\d\d\/\d\d)"$/ do |date|
  Time.stub(:now).and_return(date)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

Given /the following dogs exist/ do |dogs_table|\
  Dog.any_instance.stub(:geocode)
  dogs_table.hashes.each do |dog|
    new_dog = Dog.new()
    new_dog.user_id = dog[:user_id]
    new_dog.name = dog[:name]
    new_dog.gender = dog[:gender]
    new_dog.size_id = Size.find_by_value(dog[:size]).id
    new_dog.dob = DateTime.new(Time.now.year - dog[:age].to_i, 3, 3)
    new_dog.mixes << Mix.find_by_value(dog[:mix])
    new_dog.personalities << Personality.find_by_value(dog[:personality])
    new_dog.likes << Like.find_by_value(dog[:likes])
    new_dog.energy_level_id = EnergyLevel.find_by_value(dog[:energy]).id
    new_dog.latitude = dog[:latitude]
    new_dog.longitude = dog[:longitude]
    new_dog.save!
  end
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

Given /^my IP address is (\d+\.\d+\.\d+\.\d+)$/ do |ip|
  ApplicationController.stubbed_request_ip = ip
end

Then /"(.*)" should appear before "(.*)"/ do |first_example, second_example|
  page.body.should =~ /#{first_example}.*#{second_example}/m
end

After do
  ApplicationController.stubbed_request_ip = nil
end

And /^I press Schedule$/ do
  DogsController.any_instance.stub(:get_date).and_return(DateTime.now.to_date)
  click_button("Schedule")
end

