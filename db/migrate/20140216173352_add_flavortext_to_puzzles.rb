class AddFlavortextToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :flavortext, :text
  end
end
