class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :user_id
      t.integer :likeable_id
      t.string :likeable_type
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
