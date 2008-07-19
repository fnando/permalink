ActiveRecord::Schema.define(:version => 0) do
  create_table :beers do |t|
    t.string :name, :permalink
    t.integer :bookmarks_count, :default => 0, :null => false
  end
  
  create_table :donuts do |t|
    t.string :flavor, :slug
    t.integer :bookmarks_count, :default => 0, :null => false
  end
end