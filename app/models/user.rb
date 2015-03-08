class User < ActiveRecord::Base
  attr_accessor :uid, :name, :first_name, :last_name, :oauth_token, :oauth_expires_at

  def auth_update(auth)
    oauth_token = auth.oauth_token
    oauth_expires_at = auth.oauth_expires_at
  end
end
