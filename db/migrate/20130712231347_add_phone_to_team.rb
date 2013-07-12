class AddPhoneToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :phone, :string
  end
end
