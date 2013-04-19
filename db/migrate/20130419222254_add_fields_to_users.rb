class AddFieldsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :created, :timestamp
    add_column :users, :modified, :timestamp
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :nickname
    remove_column :users, :created
    remove_column :users, :modified
  end
end
