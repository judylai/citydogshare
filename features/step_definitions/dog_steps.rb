When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

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
end
