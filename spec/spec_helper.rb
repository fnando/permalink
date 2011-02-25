require "rspec"
require "active_record"
require "mongoid"
require "active_support/test_case"
require "permalink"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load("schema.rb")

Mongoid.configure do |config|
  name = "permalink"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  config.persist_in_safe_mode = false
end

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|file| require file}
