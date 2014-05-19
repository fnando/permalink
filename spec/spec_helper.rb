require "bundler/setup"
require "permalink"

ActiveRecord::Base
  .establish_connection(adapter: "sqlite3", database: ":memory:")

load("support/schema.rb")
require "support/user"
require "support/post"
