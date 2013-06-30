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
      true
    else
      false
    end
  end

  alias :save! :save

private

  def token_valid?
    @team = Team.first conditions: {token: @token}
    #raise @team.inspect
    errors[:token] = "Invalid team token" unless @team
  end

  def persist!
    @player.team = @team
    @player.save!
  end
end
