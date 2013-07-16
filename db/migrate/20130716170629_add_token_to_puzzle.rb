class AddTokenToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :token, :string
  end
end
