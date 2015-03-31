class Dog < ActiveRecord::Base
  attr_accessible :name, :image, :dob, :gender, :description, :motto, :fixed, :health, :comments, :contact, :availability

  belongs_to :user
  has_many :mixes
  has_many :likes
  has_one :personality
  has_one :energy_level
  has_one :size



end