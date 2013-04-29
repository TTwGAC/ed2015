class Team < ActiveRecord::Base

  RESERVED_NAMES = [
    "Game Control",
    "Observers"
  ].map {|team| team.downcase}

  attr_accessible :name, :slogan, :description, :logo, :logo_cache
  validates :name, :presence => true, :uniqueness => true, :if => :reserved_name?
  before_save :create_token
  has_many :users
  mount_uploader :logo, LogoUploader

  def reserved_name?
    errors[:name] << "Reserved team names may not be used" if RESERVED_NAMES.include? name.downcase
  end

  def create_token
    # Yes, this is not ideal but it's probably good enough
    self.token ||= Digest::MD5.hexdigest "#{Time.now}-#{Time.now.nsec}-#{rand 99999}"
  end
end

# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  created     :datetime
#  updated     :datetime
#  description :text
#  slogan      :string(255)
#  logo        :string(255)
#  token       :string(255)
#

