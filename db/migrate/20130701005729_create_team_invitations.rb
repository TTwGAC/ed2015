class CreateTeamInvitations < ActiveRecord::Migration
  def change
    create_table :team_invitations do |t|
      t.integer :player_id
      t.integer :team_id
      t.string :email

      t.timestamps
    end
  end
end
