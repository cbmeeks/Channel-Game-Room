class RenameColumnsInVideolinks < ActiveRecord::Migration
  def self.up
    rename_column :videolinks, :embed, :url_html
  end

  def self.down
    rename_column :videolinks, :url_html, :embed
  end
end
