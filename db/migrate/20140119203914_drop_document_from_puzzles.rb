class DropDocumentFromPuzzles < ActiveRecord::Migration
  def up
    remove_column :puzzles, :document
  end

  def down 
    add_column :puzzles, :document, :string
  end
end
