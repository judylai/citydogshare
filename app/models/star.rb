class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog
  attr_accessible :user, :dog
end
