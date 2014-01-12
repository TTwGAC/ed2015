class ChangeClusterOrderToSequence < ActiveRecord::Migration
  def change
    rename_column :clusters, :order, :sequence
  end
end
