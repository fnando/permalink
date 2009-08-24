ActiveRecord::Schema.define(:version => 0) do
  create_table :beers do |t|
    t.string :name, :permalink
  end
  
  create_table :users do |t|
    t.string :name, :permalink
  end
  
  create_table :donuts do |t|
    t.string :flavor, :slug
  end
  
  create_table :posts do |t|
    t.string :title
    t.string :permalink, :unique => true
  end
end