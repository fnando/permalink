require "rubygems"
require "active_record"
require "active_support/test_case"
require "permalink"

Dir.glob(File.dirname(__FILE__) + "/support/models/*.rb").each { |r| require r }
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load("support/schema.rb")
