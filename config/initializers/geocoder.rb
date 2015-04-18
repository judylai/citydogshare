# config/initializers/geocoder.rb
Geocoder.configure(
  :timeout => 15,
  :ip_lookup => :telize

)