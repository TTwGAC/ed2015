class AddOwnerToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :owner_id, :integer
  end
end
