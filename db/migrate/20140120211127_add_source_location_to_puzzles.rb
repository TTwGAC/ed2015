class AddSourceLocationToPuzzles < ActiveRecord::Migration
  def change
    rename_column :puzzles, :location_id, :destination_id
    add_column :puzzles, :origin_id, :integer
  end
end
