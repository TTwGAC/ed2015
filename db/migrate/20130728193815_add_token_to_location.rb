class AddTokenToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :token, :string
    Location.all.each do |loc|
      loc.get_token
      loc.save!
    end
  end

  def down
    remove_column :locations, :token, :string
  end
end
