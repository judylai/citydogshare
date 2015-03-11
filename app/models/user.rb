class User < ActiveRecord::Base
  attr_accessible :uid, :first_name, :last_name, :oauth_token, :oauth_expires_at, :location, :gender, :image, :status, :phone_number, :email, :availability, :description

  def update_credentials(credentials)
    self.oauth_token = credentials[:token]
    self.oauth_expires_at = credentials[:expires_at]
    self.save 
  end

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

end
