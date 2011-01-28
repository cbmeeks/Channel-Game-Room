class AddPermalinkToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :permalink, :string
  end

  def self.down
    remove_column :games, :permalink
  end
end
