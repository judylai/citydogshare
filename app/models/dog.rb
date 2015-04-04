class Dog < ActiveRecord::Base
  attr_accessible :name, :image, :dob, :gender, :description, :motto, :fixed, :health, :comments, :contact, :availability, :mixes, :likes, :energy_level, :size, :personalities, :photo

  belongs_to :user
  has_many :dog_mix_linkers
  has_many :dog_like_linkers
  has_many :dog_personality_linkers
  has_many :mixes, :through => :dog_mix_linkers
  has_many :likes, :through => :dog_like_linkers
  has_many :personalities, :through => :dog_personality_linkers
  belongs_to :energy_level
  belongs_to :size

  #has_attached_file :photo, :styles => { :small => "150x150>" },
  #                :url  => "/assets/dogs/:id/:style/:basename.:extension",
  #                :path => ":rails_root/public/assets/dogs/:id/:style/:basename.:extension"

  validates :name, :presence => {:message => "Name can't be blank"}
  validates :mixes, :presence => {:message => "Mix can't be blank"}
  #validates_attachment_presence :photo, :message => "Please attach a photo"
  #validates_attachment_size :photo, :less_than => 5.megabytes, :message => "Photo cannot be larger than 5MB"
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png'], :message => "Please upload photo as a .jpeg or .png"





  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end


end