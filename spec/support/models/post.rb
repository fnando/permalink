class Post < ActiveRecord::Base
  permalink :title, :unique => true, :to_param => :permalink

  validates_uniqueness_of :permalink
end
