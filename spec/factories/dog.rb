
FactoryGirl.define do
  factory :dog do
    name "Batman"
    gender "Male"
    dob DateTime.new(2010, 2)
    description "I'm a dog."
    motto "Smile"
    availability "Always"
    size_id 1
    energy_level_id 1
  end
end
