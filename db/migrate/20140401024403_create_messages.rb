class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :sender_id
      t.string :delivery_type
      t.string :status
      t.string :destination
      t.timestamps
    end
  end
end
