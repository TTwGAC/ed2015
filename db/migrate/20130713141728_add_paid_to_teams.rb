class AddPaidToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :paid, :boolean
  end
end
