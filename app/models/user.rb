class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :location, :gender, :image, :status, :phone_number, :email, :availability, :description
  validates :phone_number, format: { with: /\(\d{3}\)(\ ?)\d{3}-\d{4}/, message: "Bad format for phone number." }, :allow_blank => true

  def update_credentials(credentials)
    self.oauth_token = credentials[:token]
    self.oauth_expires_at = Time.at(credentials[:expires_at].to_i)
    self.save 
  end

  def facebook_info_update(auth)
    self.uid = auth[:uid]
    self.gender = auth[:extra][:gender]
    self.first_name = auth[:info][:first_name]
    self.last_name = auth[:info][:last_name]
    self.image = auth[:info][:image][0..-7] + "large"
    self.location = auth[:info][:location]
    self.email = auth[:info][:email]
    self.save
  end

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

end
