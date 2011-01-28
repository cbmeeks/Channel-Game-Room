class ChangeVideolinks < ActiveRecord::Migration
  def self.up
    change_column :videolinks, :url, :text
    rename_column :videolinks, :url, :embed
  end

  def self.down
    change_column :videolinks, :url, :string
    rename_column :videolinks, :embed, :url
  end
end
