class CreateVideolinks < ActiveRecord::Migration
  def self.up
    create_table :videolinks do |t|
      t.integer :game_id
      t.string :provider
      t.string :url
      t.string :video_id

      t.timestamps
    end
  end

  def self.down
    drop_table :videolinks
  end
end
