class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.integer :team_id
      t.integer :assigner_id
      t.integer :puzzle_id
      t.text :description
      t.integer :minutes

      t.timestamps
    end
  end
end
