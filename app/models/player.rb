class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook, :twitter]

  belongs_to :team
  has_many :team_invitations
  has_many :checkins
  before_save :default_team
  delegate :name, :id, :location, :to => :team, :prefix => true
  mount_uploader :avatar, AvatarUploader
  ROLES = %w[admin player observer none]

  def default_team
    self.team ||= Team.first conditions: {name: "Observers"}
  end

  def role
    return "none" unless self.id
    self.team ||= default_team
    case team.name
    when "Game Control"
      return "admin"
    when "Observers"
      return "observer"
    else
      return "player"
    end
  end

  def has_required_fields?
    self.first_name && self.last_name
  end

  def name
    name = "#{self.first_name} "
    name << %Q{"#{self.nickname}" } if self.nickname
    name << self.last_name.to_s
    name
  end
end

# == Schema Information
#
# Table name: players
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  nickname               :string(255)
#  created                :datetime
#  modified               :datetime
#  role                   :string(255)
#  team_id                :integer
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  avatar                 :string(255)
#  facebook_uid           :string(255)
#  facebook_token         :string(255)
#  twitter_uid            :string(255)
#  twitter_token          :string(255)
#  twitter_secret         :string(255)
#  twitter_handle         :string(255)
#

