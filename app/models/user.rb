class User < ActiveRecord::Base
  attr_accessible :uid, :name, :first_name, :last_name, :oauth_token, :oauth_expires_at, :location, :gender, :image, :status, :phone_number, :email, :availability, :description

end
