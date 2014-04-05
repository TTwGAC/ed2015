class AddIncludeBearingToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :include_bearing, :boolean
  end
end
