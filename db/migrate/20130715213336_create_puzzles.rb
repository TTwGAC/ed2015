class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :name
      t.integer :location_id
      t.string :document
      t.timestamps
    end
  end
end


