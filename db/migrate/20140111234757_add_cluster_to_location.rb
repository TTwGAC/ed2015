class AddClusterToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :cluster_id, :integer
  end
end
