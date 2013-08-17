class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :player_id, null: false
      t.string :subject, null: false
      t.integer :subject_id
      t.string :action, null: false
      t.string :description

      t.timestamps
    end
  end
end
