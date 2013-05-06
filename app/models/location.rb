class Location < ActiveRecord::Base
  attr_accessible :address

  acts_as_gmappable

  def gmaps4rails_address
    self.address
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
#

