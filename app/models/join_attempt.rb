class JoinAttempt
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :token
  attr_reader :user, :team

  #belongs_to :user

  validate :token_valid?
  #validates :user, presence: true

  def initialize(params = {})
    @token = params[:token]
  end

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      raise "Done!"
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
    raise "BLAT"
    @user.team = @team
    @user.save!
    redirect_to "/teams/#{team.id}"
    @user = @company.users.create!(name: name, email: email)
  end
end