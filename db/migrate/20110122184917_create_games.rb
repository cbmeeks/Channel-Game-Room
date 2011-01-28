class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :system_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
