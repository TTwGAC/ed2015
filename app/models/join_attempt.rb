class JoinAttempt
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :token
  attr_reader :player, :team
  delegate :id, :to => :team, :prefix => true

  #belongs_to :player

  validate :token_valid?
  #validates :player, presence: true

  def initialize(params = {})
    @token = params[:token]
    @player  = params[:player]
  end

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      notify_team
    end
  end

  alias :save! :save

private

  def token_valid?
    @token.strip!
    @team = Team.where(token: @token).first
    unless @team
      # No team found? Try searching invitations
      invitation = TeamInvitation.where(token: @token).first
      if invitation
        @team = invitation.team
        invitation.delete
      end
    end

    errors[:token] = "Invalid team token" unless @team
    @team
  end

  def persist!
    @player.team = @team
    @player.save!
  end

  def notify_team
    @team.players.each do |player_to_notify|
      unless @player == player_to_notify
        TeamMailer.notify_member_joined(@player, player_to_notify, @team).deliver!
      end
    end
  end
end
