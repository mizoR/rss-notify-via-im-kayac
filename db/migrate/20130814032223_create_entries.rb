class CreateEntries < ActiveRecord::Migration
  def up
    create_table :entries do |t|
      t.integer :rss_id, :null => true
      t.string :title  , :null => false, :default => ''
      t.string :url    , :null => false, :default => ''
      t.text   :content, :null => false, :default => ''
      t.timestamps
    end
    add_index :entries, :rss_id
    add_index :entries, :created_at
    add_index :entries, :updated_at
  end

  def down
    drop_table :entries
  end
end
