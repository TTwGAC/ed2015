class AddHotlineOpenToGame < ActiveRecord::Migration
  def change
    add_column :games, :hotline_open, :boolean
  end
end
