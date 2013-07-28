class Location < ActiveRecord::Base
  has_many :puzzles
  has_many :teams
  before_save :get_token
  acts_as_gmappable :process_geocoding => :geocode?, :normalized_address => "address",
                    :lat => 'latitude', :lng => "longitude"

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  def gmaps4rails_address
    self.address
  end

  def get_token
    self.token ||= SecureRandom.hex(16)
  end
end

# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

