require 'utility'

class TeamInvitation < ActiveRecord::Base
  include Utility
  belongs_to :team
  belongs_to :player
  before_save :create_token

  def create_token
    self.token ||= ::Utility.gen_token
  end

end
