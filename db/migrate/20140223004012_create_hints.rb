class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.text :hint
      t.integer :puzzle_id
      t.integer :suggested_penalty
      t.timestamps
    end
  end
end
