# config/initializers/geocoder.rb
Geocoder.configure(
  :timeout => 20,
  :ip_lookup => :telize

)