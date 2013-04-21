class Team < ActiveRecord::Base

  RESERVED_NAMES = [
    "Game Control",
    "Observers"
  ].map {|team| team.downcase}

  attr_accessible :name, :slogan, :description
  validates :name, :presence => true, :uniqueness => true, :if => :reserved_name?
  has_many :users
  mount_uploader :logo, LogoUploader

  def reserved_name?
    errors[:name] << "Reserved team names may not be used" if RESERVED_NAMES.include? name.downcase
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
#

