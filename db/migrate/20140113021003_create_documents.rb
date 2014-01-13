class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :token, null: false
      t.boolean :private

      t.timestamps
    end
  end
end
