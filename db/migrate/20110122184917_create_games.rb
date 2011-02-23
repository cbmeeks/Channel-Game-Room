class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :system_id
      t.string :title
      t.text :description
      t.column :search_vector, 'tsvector'
      
      t.timestamps
    end
    
    execute <<-EOS
      CREATE INDEX games_search_idx ON games USING gin(search_vector)
    EOS
    
    execute <<-EOS
      DROP TRIGGER IF EXISTS games_vector_update ON games
    EOS
    
    execute <<-EOS
      CREATE TRIGGER games_vector_update BEFORE INSERT OR UPDATE
      ON games
      FOR EACH ROW EXECUTE PROCEDURE
        tsvector_update_trigger(search_vector, 'pg_catalog.english', title, description);    
    EOS
    
    Game.find_each {|g| g.touch} # touch each row. applies trigger to existing rows (for index)
  end

  def self.down
    drop_table :games
  end
end
