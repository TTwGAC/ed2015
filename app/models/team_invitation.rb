require 'utility'

class TeamInvitation < ActiveRecord::Base
  include Utility
  belongs_to :team
  belongs_to :player
  attr_accessible :team, :player, :email
  before_save :create_token

  def create_token
    self.token ||= ::Utility.gen_token
  end

end
