class DogPersonalityLinker < ActiveRecord::Base
  belongs_to :dog
  belongs_to :personality
end