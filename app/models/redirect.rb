class Redirect < ActiveRecord::Base
  validates :token, presence: true
  validates :name, presence: true
  validates :destination_url, presence: true, format: { with: URI::regexp(%w(http https)) }
end
