When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field, match: :first)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field, match: :first)
end

And /^And I select "([^"]*)" and press enter$/ do |mix|
  page.driver.browser.key_down(:arrow_left).key_up(:arrow_left).perform
  page.driver.browser.key_down(:enter).key_up(:enter).perform
end

When /^I create a new dog "([^"]*)"$/ do |name|
  FactoryGirl.create(:dog)
end

And /^I fill in the mix box with "([^"]*)"$/ do |text|
  page.find(:css, "dog_mix")
end

Then /^wait$/ do
  sleep 2
end