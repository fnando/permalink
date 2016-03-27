require "active_record"
require "permalink/active_record"

module Permalink
  def self.generate(str)
    str = ActiveSupport::Multibyte::Chars.new(str)
    str = str.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
    str.gsub!(/'/, "")
    str.gsub!(/[^-\w\d]+/sim, "-")
    str.gsub!(/-+/sm, "-")
    str.gsub!(/^-?(.*?)-?$/, '\1')
    str.downcase!
    str
  end
end

ActiveRecord::Base.send(:include, Permalink::ActiveRecord)
