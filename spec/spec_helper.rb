require "mongo_mapper"
# require "mongoid"
require "rspec"
require "active_record"
require "permalink"

# Setup ActiveRecord
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

# Setup MongoMapper
MongoMapper.connection = Mongo::Connection.new("localhost")
MongoMapper.database = "permalink"

# Setup Mongoid
# Mongoid.configure do |config|
#   name = "permalink"
#   host = "localhost"
#   config.master = Mongo::Connection.new.db(name)
#   config.persist_in_safe_mode = false
# end

load("support/schema.rb")
require "support/page"
require "support/shared"
require "support/post"
# require "support/article"
