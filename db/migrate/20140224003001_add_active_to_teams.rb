class AddActiveToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :active, :boolean
    Team.all.each { |t| t.active = true; t.save! }
  end
end
