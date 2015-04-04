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
    availability ""
    size_id { Size.find(1) }
    energy_level { EnergyLevel.find(1) }
    personalities { [Personality.find(1)] }
    user_id { 1 }
    photo_file_name "dog.jpg"
    photo_content_type "image/jpeg"
    photo_file_size { 553692 } 
    photo_updated_at Date.new(2015, 4, 3)
  end
end