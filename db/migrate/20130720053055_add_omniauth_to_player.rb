class AddOmniauthToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :facebook_uid, :string
    add_column :players, :facebook_token, :string
    add_column :players, :twitter_uid, :string
    add_column :players, :twitter_token, :string
    add_column :players, :twitter_secret, :string
  end
end
