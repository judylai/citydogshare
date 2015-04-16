class Dog < ActiveRecord::Base
  attr_accessible :name, :image, :dob, :gender, :description, :motto, :fixed, :health, :comments, :contact, :availability, :mixes, :likes, :energy_level, :size, :personalities, :photo, :latitude, :longitude

  scope :has_gender, lambda {|genders| where("gender" => genders) unless genders.empty?}
  scope :has_personalities, lambda {|personalities| joins(:personalities).where("personalities.value" => personalities) unless personalities.empty?}
  scope :has_likes, lambda {|likes| joins(:likes).where("likes.value" => likes) unless likes.empty?}
  scope :has_mix, lambda {|mix| joins(:mixes).where("mixes.value" => mix) unless mix == "All Mixes"}
  scope :has_energy_level, lambda {|energy_levels| joins(:energy_level).where("energy_levels.value" => energy_levels) unless energy_levels.empty?}
  scope :has_size, lambda {|sizes| joins(:size).where("sizes.value" => sizes) unless sizes.empty?}
  scope :in_age_range, lambda {|age_query| where(age_query) unless age_query == ""}

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

  after_validation :geocode

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

  def self.genders
    ["Male", "Female"]
  end

  def self.age_ranges
    ["0-2 years", "2-4 years", "5-8 years", "9+ years"]
  end

  def get_base(i)
        first = (Time.now - ranges[i][1].years).strftime "%Y-%m-%d %H:%M:%S"
        second = (Time.now - ranges[i][0].years).strftime "%Y-%m-%d %H:%M:%S"
        base = %Q[("dogs"."dob" BETWEEN '#{first}' AND '#{second}')]
  end

  def dob_query
    ranges = [[0, 2], [2, 4], [5, 8], [9, 30]]
    age_query = ""
    criteria[:age].each do |i|
        # t.strftime "%Y-%m-%d %H:%M:%S %z"
        base = get_base(i.to_i)
        if i.to_i < criteria[:age].length - 1
          age_query += (base + " OR ")
        else
          age_query += base
        end
    end
    age_query
  end

  def self.filter_by(criteria)
    dogs = Dog.near(criteria[:zipcode], criteria[:radius], order: :distance)
              .has_mix(criteria[:mix])
              .has_size(criteria[:sizes])
              .has_likes(criteria[:likes])
              .has_personalities(criteria[:personalities])
              .has_gender(criteria[:gender])
              .has_energy_level(criteria[:energy_levels])
              .in_age_range(dob_query)
  end

    # def filter_multiple_attributes(arg)
    # instance_variable_set("@" + "selected_#{arg.pluralize}", get_checkbox_selections(arg))

    # method_name = "readable_#{arg.pluralize}"
    # unless instance_variable_get("@" + "selected_#{arg.pluralize}").empty?
    #   @dogs = @dogs.select do |dog|
    #     (dog.public_send(method_name) - instance_variable_get("@" + "selected_#{arg.pluralize}")).length < dog.public_send(method_name).length  if dog.respond_to? method_name
    #   end
    # end

end
