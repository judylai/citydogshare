FactoryGirl.define do
  factory :user do
    first_name "Eric"
    last_name "Husk"
    gender "Male"
    status "Looking"
    phone_number "(123)123-1234"
    email "eric@husk.com"
    availability "All the time"
    description "Hello everyone"
    address "387 Soda Hall"
    zipcode "94720"
    city "Berkeley"
    country "US"
    id 1
    uid "12345"
  end
end