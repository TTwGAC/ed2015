class AddMetadataToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :team_id, :integer
    add_column :checkins, :player_id, :integer
  end
end
