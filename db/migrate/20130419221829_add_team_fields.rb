class AddTeamFields < ActiveRecord::Migration
  def up
    add_column :teams, :name, :string
    add_column :teams, :created, :timestamp
    add_column :teams, :updated, :timestamp
    add_column :teams, :description, :text
    add_column :teams, :slogan, :string
  end

  def down
    remove_column :teams, :name
    remove_column :teams, :created
    remove_column :teams, :updated
    remove_column :teams, :description
    remove_column :teams, :slogan
  end
end
