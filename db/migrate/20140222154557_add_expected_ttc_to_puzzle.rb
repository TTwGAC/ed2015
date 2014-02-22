class AddExpectedTtcToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :expected_ttc, :integer
  end
end
