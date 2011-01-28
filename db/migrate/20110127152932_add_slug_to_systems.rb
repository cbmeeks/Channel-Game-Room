class AddSlugToSystems < ActiveRecord::Migration
  def self.up
    add_column :systems, :slug, :string
  end

  def self.down
    remove_column :systems, :slug
  end
end
