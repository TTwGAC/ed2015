class RenameUserToPlayer < ActiveRecord::Migration
  def up
    rename_table :users, :players
  end

  def down
    rename_table :users, :players
  end
end
