FactoryGirl.define do
  factory :dog do
    name "Spock"
    gender "Male"
    dob Date.new(2010, 2, 3)
    mixes { [Mix.find(1)] }
    description ""
    motto ""
    fixed false
    health ""
    contact nil 
    availability ""
    size { Size.find(1) }
    energy_level { EnergyLevel.find(1) }
    personalities { Personality.find(1) }
  end
end