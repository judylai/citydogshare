class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog
  attr_accessible :user, :dog
  validates_uniqueness_of :user_id, :dog_id
end
