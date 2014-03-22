class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :token
      t.string :name
      t.string :destination_url
      t.timestamps
    end
  end
end
