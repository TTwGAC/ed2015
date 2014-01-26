class Cluster < ActiveRecord::Base
  COLORS = %w[blue brown darkgreen green orange paleblue pink purple red yellow]
  has_many :locations
  validates_inclusion_of :color, in: COLORS
  validates_presence_of :name
  validates_uniqueness_of :sequence

  def next_cluster
    Cluster.where('sequence > ?', sequence).order('sequence').first
  end
end

# == Schema Information
#
# Table name: clusters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sequence   :integer
#  color      :string(255)      default("red")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

