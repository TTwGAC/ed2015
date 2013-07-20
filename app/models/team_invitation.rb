class TeamInvitation < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  before_save :create_token

  def create_token
    self.token ||= SecureRandom.hex(12)
  end

end

# == Schema Information
#
# Table name: team_invitations
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  team_id    :integer
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string(255)
#

