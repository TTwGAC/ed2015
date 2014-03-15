class AddOpenToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :open, :boolean
  end
end
