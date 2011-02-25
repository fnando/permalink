ActiveRecord::Schema.define(:version => 0) do
  create_table :posts do |t|
    t.string :title, :permalink, :slug
  end
end
