class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook, :twitter]

  belongs_to :team
  has_many :team_invitations
  before_save :default_team
  delegate :name, :id, :to => :team, :prefix => true
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

  class << self
    def find_or_create_for_facebook_oauth(auth, signed_in_resource = nil)
      credentials = {
        facebook_uid: auth.uid,
        facebook_token: auth.credentials.token
      }
      info = {
        email: auth.info.email,
        first_name: auth.extra.raw_info.first_name,
        last_name: auth.extra.raw_info.last_name,
      }
      find_or_create({facebook_uid: auth.uid}, credentials, info)
    end

    def find_or_create_for_twitter_oauth(auth, signed_in_resource = nil)
      credentials = {
        twitter_uid: auth.uid,
        twitter_token: auth.credentials.token,
        twitter_secrent: auth.credentials.secrent
      }
      info = {
        twitter_handle: auth.info.nickname
      }
      find_or_create({twitter_uid: auth.uid}, credentials, info)
    end

    def find_or_create(locator, credentials, info)
      player = Player.where(locator).first
      unless player
        player = Player.where(email: info[:email]).first

        if player
          # Link the existing player to this account
          credentials.keys.each do |key|
            player[key] = credentials[key]
          end
          info.keys.each do |key|
            # Prefer info already in our database
            player[key] ||= info[key]
          end
        else
          # Create a new Player
          player = Player.create({password: Devise.friendly_token}.merge(info))
        end
      end
      player
    end
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

