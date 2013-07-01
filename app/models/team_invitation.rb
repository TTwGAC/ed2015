class TeamInvitation < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  attr_accessible :team, :player, :email
end
