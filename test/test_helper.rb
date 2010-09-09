require "rubygems"
gem "test-unit"
require "test/unit"
require "active_record"
require "active_support/test_case"
require "permalink"

Dir.glob(File.dirname(__FILE__) + "/models/*.rb").each {|r| require r }
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ":memory:")
load('schema.rb')
