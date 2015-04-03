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

When /^I type in "([^\"]*)" into autocomplete list "([^\"]*)" and I choose "([^\"]*)"$/ do |typed, input_name,should_select|
   page.driver.browser.execute_script %Q{ $('input[data-autocomplete]').trigger("focus") }
   fill_in("#{input_name}",:with => typed)
   page.driver.browser.execute_script %Q{ $('input[data-autocomplete]').trigger("keydown") }
   sleep 1
   page.driver.browser.execute_script %Q{ $('.ui-menu-item a:contains("#{should_select}")').trigger("mouseenter").trigger("click"); }
end