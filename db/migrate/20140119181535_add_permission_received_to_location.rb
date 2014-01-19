class AddPermissionReceivedToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :permission_received, :boolean
  end
end
