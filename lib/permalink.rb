require "permalink/string_ext"
require "permalink/orm/base"
require "permalink/orm/active_record"
require "permalink/orm/mongo_mapper"
require "permalink/orm/mongoid"

ActiveRecord::Base.send(:include, Permalink::Orm::ActiveRecord) if defined?(ActiveRecord)
Mongoid::Document::ClassMethods.send(:include, Permalink::Orm::Mongoid) if defined?(Mongoid)
