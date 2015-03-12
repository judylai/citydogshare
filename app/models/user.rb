class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :location, :gender, :image, :status, :phone_number, :email, :availability, :description

  def update_credentials(credentials)
    self.oauth_token = credentials[:token]
    self.oauth_expires_at = credentials[:expires_at].to_i
    self.save 
  end

  def facebook_info_update(auth)
    self.uid = auth[:uid]
    self.gender = auth[:extra][:gender]
    self.first_name = auth[:info][:first_name]
    self.last_name = auth[:info][:last_name]
    self.image = auth[:info][:image]
    self.location = auth[:info][:location]
    self.email = auth[:info][:email]
  end

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

end
