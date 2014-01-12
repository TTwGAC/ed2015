class Cluster < ActiveRecord::Base
  COLORS = %w[blue brown darkgreen green orange paleblue pink purple red yellow]
  has_many :locations
  validates_inclusion_of :color, in: COLORS
end
