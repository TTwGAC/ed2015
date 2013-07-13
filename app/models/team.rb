require 'utility'

class Team < ActiveRecord::Base

  RESERVED_NAMES = [
    "Game Control",
    "Observers"
  ].map {|team| team.downcase}

  validates :name, :presence => true, :uniqueness => true, :if => :reserved_name?
  validates_plausible_phone :phone
  before_save :create_token
  before_destroy :reset_members_to_observers
  has_many :players
  has_many :team_invitations
  mount_uploader :logo, LogoUploader
  phony_normalize :phone, :default_country_code => 'US'

  def reserved_name?
    errors[:name] << "Reserved team names may not be used" if RESERVED_NAMES.include? name.downcase
  end

  def create_token
    self.token ||= ::Utility.gen_token
  end

  def reset_members_to_observers
    observers = Team.where(name: 'Observers').first
    self.players.each do |player|
      player.team = observers
      player.save!
    end
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

