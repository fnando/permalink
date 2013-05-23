require "permalink/string_ext"
require "permalink/orm/base"
require "permalink/orm/active_record"

ActiveRecord::Base.send(:include, Permalink::Orm::ActiveRecord) if defined?(ActiveRecord)
