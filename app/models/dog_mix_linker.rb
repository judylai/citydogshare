class DogMixLinker < ActiveRecord::Base
  belongs_to :dog
  belongs_to :mix
end