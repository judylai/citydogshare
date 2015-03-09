class User < ActiveRecord::Base
  attr_accessible :uid, :name, :first_name, :last_name, :oauth_token, :oauth_expires_at

end
