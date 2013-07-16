class TeamInvitation < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  before_save :create_token

  def create_token
    self.token ||= SecureRandom.hex(12)
  end

end
