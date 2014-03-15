class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
