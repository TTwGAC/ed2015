# encoding: utf-8

class AddStatusToPuzzles < ActiveRecord::Migration
  def change
    add_column :puzzles, :status, :string
  end
end
