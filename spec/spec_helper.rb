require "mongo_mapper"
require "mongoid"
require "rspec"
require "active_record"
require "permalink"

# Setup ActiveRecord
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

load("support/schema.rb")
require "support/shared"
require "support/post"
