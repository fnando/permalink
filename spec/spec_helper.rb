require "rspec"
require "active_record"
require "active_support/test_case"
require "permalink"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load("schema.rb")

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|file| require file}
