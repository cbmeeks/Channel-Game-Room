class AddUrlToVideolinks < ActiveRecord::Migration
  def self.up
    add_column :videolinks, :url, :string
  end

  def self.down
    remove_column :videolinks, :url
  end
end
