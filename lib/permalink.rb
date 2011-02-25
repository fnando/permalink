require "active_record"
require "permalink/string_ext"
require "permalink/orm/active_record"

ActiveRecord::Base.send(:include, Permalink::Orm::ActiveRecord) if defined?(ActiveRecord::Base)
