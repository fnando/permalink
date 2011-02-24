require "rubygems"
require "active_record"
require "active_support/test_case"
require "mongoid"
require "permalink"

Dir.glob(File.dirname(__FILE__) + "/support/models/*.rb").each { |r| require r }
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load("support/schema.rb")

Mongoid.configure do |config|
  name = "permalink_test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  config.persist_in_safe_mode = false
end

RSpec.configure do |config|
  config.after :suite do
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
  end
end
