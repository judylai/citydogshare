require 'cucumber/rspec/doubles'

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
