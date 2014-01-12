class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.string :name
      t.integer :order
      t.string :color, default: 'red'

      t.timestamps
    end
  end
end
