# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
  attr_accessible :name
  has_many :users
end
