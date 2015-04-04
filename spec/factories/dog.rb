FactoryGirl.define do
  factory :dog do
    name "Spock"
    gender "Male"
    dob Date.new(2010, 2, 3)
    mixes { [Mix.find(1)] }
    description ""
    motto "Live long and play fetch."
    fixed false
    health ""
    availability ""
    size { Size.find(1) }
    energy_level { EnergyLevel.find(1) }
    personalities { [Personality.find(1)] }
    user_id { 1 }
  end
end