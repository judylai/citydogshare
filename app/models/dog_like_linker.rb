class DogLikeLinker < ActiveRecord::Base
  belongs_to :dog
  belongs_to :like
end