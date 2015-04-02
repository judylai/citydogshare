class Dog < ActiveRecord::Base
  attr_accessible :name, :image, :dob, :gender, :description, :motto, :fixed, :health, :comments, :contact, :availability

  belongs_to :user
  has_many :dog_mix_linkers
  has_many :dog_like_linkers
  has_many :dog_personality_linkers
  has_many :mixes, :through => :dog_mix_linkers
  has_many :likes, :through => :dog_like_linkers
  has_many :personalities, :through => :dog_personality_linkers
  belongs_to :energy_level
  belongs_to :size

  


end