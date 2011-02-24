class Article
  include Mongoid::Document
  field :title

  permalink :title, :unique => true, :to_param => :permalink

  validates :permalink, :uniqueness => true
end
