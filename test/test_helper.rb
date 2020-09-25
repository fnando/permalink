# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "bundler/setup"
require "permalink"

require "minitest/utils"
require "minitest/autorun"

ActiveRecord::Base
  .establish_connection(adapter: "sqlite3", database: ":memory:")

load("support/schema.rb")
require "support/user"
require "support/post"
