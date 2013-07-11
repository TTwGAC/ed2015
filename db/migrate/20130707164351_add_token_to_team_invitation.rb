class AddTokenToTeamInvitation < ActiveRecord::Migration
  def change
    add_column :team_invitations, :token, :string
  end
end
