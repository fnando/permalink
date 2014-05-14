require "active_record"
require "permalink/string_ext"
require "permalink/active_record"

ActiveRecord::Base.send(:include, Permalink::ActiveRecord)
