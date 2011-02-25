class Page
  include MongoMapper::Document
  include Permalink::Orm::MongoMapper
  key :title, String
end
