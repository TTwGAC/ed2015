class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.timestamp :timestamp
      t.integer :location_id

      t.timestamps
    end
  end
end
