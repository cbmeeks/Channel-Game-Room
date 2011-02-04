class AddMobyurlToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :moby_url, :string
  end

  def self.down
    remove_column :games, :moby_url
  end
end
