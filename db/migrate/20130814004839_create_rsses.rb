class CreateRsses < ActiveRecord::Migration
  def up
    create_table :rsses do |t|
      t.string :title, :null => false, :default => ''
      t.string :url  , :null => false, :default => ''
      t.timestamps
    end
    add_index :rsses, :url
    add_index :rsses, :created_at
    add_index :rsses, :updated_at
  end

  def down
    drop_table :rsses
  end
end
