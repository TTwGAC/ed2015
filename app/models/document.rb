class Document < ActiveRecord::Base
  attr_accessible :description, :name, :private

  before_save :get_token

  def get_token
    self.token ||= SecureRandom.hex(16)
  end
end
