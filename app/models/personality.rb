class Personality < ActiveRecord::Base
  attr_accessible :type
  belongs_to :dog
end