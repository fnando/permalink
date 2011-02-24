class Article
  include Mongoid::Document
  field :title

  permalink :title, :unique => true

  validates :permalink, :uniqueness => true
end
