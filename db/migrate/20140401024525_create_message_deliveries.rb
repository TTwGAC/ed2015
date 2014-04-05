class CreateMessageDeliveries < ActiveRecord::Migration
  def change
    create_table :message_deliveries do |t|
      t.integer :message_id
      t.integer :player_id
      t.string :destination
      t.string :status
      t.timestamps
    end
  end
end
