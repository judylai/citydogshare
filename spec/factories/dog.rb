FactoryGirl.define do
  factory :dog do
    name "Batman"
    gender "Male"
    dob Date.new(2010, 2, 3)
    mixes { [Mix.find(1)] }
    description ""
    motto ""
    fixed false
    health ""
    comments ""
    contact nil 
    availability ""
    size { Size.find(1) }
    energy_level { EnergyLevel.find(1) }
    personalities { Personality.find(1) }
  end
end