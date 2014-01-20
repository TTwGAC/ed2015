class Location < ActiveRecord::Base
  has_many :origin_puzzles, class_name: 'Puzzle', foreign_key: 'origin_id'
  has_many :destination_puzzles, class_name: 'Puzzle', foreign_key: 'destination_id'
  has_many :teams
  has_many :documents, as: :documentable
  belongs_to :cluster
  before_save :get_token
  delegate :name, :color, to: :cluster, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true
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
#  id                  :integer          not null, primary key
#  address             :string(255)
#  latitude            :float
#  longitude           :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string(255)
#  token               :string(255)
#  cluster_id          :integer
#  permission_received :boolean
#  open_time           :time
#  close_time          :time
#

