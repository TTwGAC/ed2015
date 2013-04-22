class JoinAttempt
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :token
  attr_reader :user, :team
  delegate :id, :to => :team, :prefix => true

  #belongs_to :user

  validate :token_valid?
  #validates :user, presence: true

  def initialize(params = {})
    @token = params[:token]
    @user  = params[:user]
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
    @user.team = @team
    @user.save!
  end
end