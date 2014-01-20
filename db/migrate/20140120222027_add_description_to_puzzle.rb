class AddDescriptionToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :description, :text
  end
end
