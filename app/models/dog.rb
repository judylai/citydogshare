class Dog < ActiveRecord::Base
  attr_accessible :name, :image, :dob, :gender, :description, :motto, :fixed, :health, :comments, :contact, :availability, :mixes, :likes, :energy_level, :size, :personalities, :photo, :latitude, :longitude

  scope :has_gender, lambda {|genders| filter_gender(genders)}
  scope :has_personalities, lambda {|personalities| filter_personality(personalities)}
  scope :has_likes, lambda {|likes| filter_like(likes)}
  scope :has_mix, lambda {|mix| filter_mix(mix)}
  scope :has_energy_level, lambda {|energy_levels| filter_energy_level(energy_levels)}
  scope :has_size, lambda {|sizes| filter_size(sizes)}
  scope :in_age_range, lambda {|age_query| filter_age(age_query)}

  belongs_to :user
  has_many :dog_mix_linkers
  has_many :dog_like_linkers
  has_many :dog_personality_linkers
  has_many :mixes, :through => :dog_mix_linkers
  has_many :likes, :through => :dog_like_linkers
  has_many :personalities, :through => :dog_personality_linkers
  belongs_to :energy_level
  belongs_to :size

  geocoded_by :address


  validates :name, :presence => {:message => "Name can't be blank"}
  validates :mixes, :presence => {:message => "Mix can't be blank"}
  validate :validate_dob

  #paperclip
  has_attached_file :photo, 
                    :styles => { :small    => '150x',
                                 :medium   => '300x' },
                    :default_url => "",
                    :storage => :s3,
                    :bucket => 'citydogshare'


  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  after_validation :geocode

  ## Attribute Access Functions
  def validate_dob
    errors.add(:dob, "Dog's birthday can't be in the future.") if (!dob.nil? and dob > Date.today)
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def energy_level
    EnergyLevel.find(self.energy_level_id).value
  end

  def size
    Size.find(self.size_id).value
  end

  def owner
    User.find(self.user_id)
  end

  def readable_mixes
    self.mixes.map {|m| m.value}
  end

  def readable_likes
    self.likes.map {|l| l.value}
  end

  def readable_personalities
    self.personalities.map {|p| p.value}
  end

  def address
    user = self.owner
    "#{user.zipcode}"
  end

  ## Attribute Possible Values Functions

  def self.genders
    ["Male", "Female"]
  end

  def self.age_ranges
    ["0-2 years", "2-4 years", "5-8 years", "9+ years"]
  end

  ## Filter Functions for Search Results (Dog Index Page)

  def self.filter_gender(genders)
    where("gender" => genders) unless genders.empty?
  end

  def self.filter_personality(personalities)
    joins(:personalities).where("personalities.value" => personalities) unless personalities.empty?
  end

  def self.filter_like(likes)
    joins(:likes).where("likes.value" => likes) unless likes.empty?
  end

  def self.filter_mix(mix)
    joins(:mixes).where("mixes.value" => mix) unless mix == "All Mixes"
  end

  def self.filter_energy_level(energy_levels)
    joins(:energy_level).where("energy_levels.value" => energy_levels) unless energy_levels.empty?
  end

  def self.filter_size(sizes)
    joins(:size).where("sizes.value" => sizes) unless sizes.empty?
  end
  
  def self.filter_age(age_query)
    where(age_query) unless age_query == ""
  end

  def self.convert_age_ranges_to_dob_query(age_ranges_indices)
    age_ranges = [[0, 2], [2, 4], [5, 8], [9, 30]]
    age_query = ""
    age_ranges_indices.each do |i|
        base = get_base(i.to_i, age_ranges)
        if i.to_i < age_ranges_indices.length - 1
          age_query += (base + " OR ")
        else
          age_query += base
        end
    end
    age_query
  end

  def self.get_base(i, ranges)
    first = (Time.now - ranges[i][1].years).strftime "%Y-%m-%d %H:%M:%S"
    second = (Time.now - ranges[i][0].years).strftime "%Y-%m-%d %H:%M:%S"
    base = %Q[("dogs"."dob" BETWEEN '#{first}' AND '#{second}')]
  end

  def self.filter_by(criteria)
    dogs = Dog.near(criteria[:zipcode], criteria[:radius], order: :distance)
              .has_mix(criteria[:mix])
              .has_size(criteria[:size])
              .has_likes(criteria[:like])
              .has_personalities(criteria[:personality])
              .has_gender(criteria[:gender])
              .has_energy_level(criteria[:energy_level])
              .in_age_range(convert_age_ranges_to_dob_query(criteria[:age]))
  end

end
