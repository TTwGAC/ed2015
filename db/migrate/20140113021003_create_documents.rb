class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :token, null: false
      t.boolean :private
      t.references :documentable, polymorphic: true
      t.timestamps
    end
  end
end
