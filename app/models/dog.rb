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


  validates :name, :presence => {:message => "Name can't be blank"}
  validates :mixes, :presence => {:message => "Mix can't be blank"}
  validate :validate_dob

  def validate_dob
    errors.add(:dob, "Dog's birthday can't be in the future.") if (!dob.nil? and dob > Date.today)
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def energy_level
    EnergyLevel.find(self.energy_level_id).level
  end

  def size
    Size.find(self.size_id).range
  end

  def owner
    User.find(self.user_id)
  end

  def readable_mixes
    self.mixes.map {|m| m.name}
  end

  def readable_likes
    self.likes.map {|l| l.thing}
  end

  def readable_personalities
    self.personalities.map {|p| p.name}
  end

end
