ENV["RAILS_ENV"] = "test"

require File.expand_path("../../../../config/environment")

begin
require "ruby-debug"
rescue LoadError
end

require "test_help"

class Object
  def self.unset_class(*args)
    class_eval do 
      args.each do |klass|
        eval(klass) rescue nil
        remove_const(klass) if const_defined?(klass)
      end
    end
  end
end

# unset models used for testing purposes
Object.unset_class('Donut', 'Beer', 'Post', 'User')

Dir.glob(File.dirname(__FILE__) + "/models/*.rb").each {|r| require r }

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ":memory:"}}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["test"])

load('schema.rb')
