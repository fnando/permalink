class Post < ActiveRecord::Base
  has_permalink :title, :unique => true, :to_param => :permalink
  
  validates_uniqueness_of :permalink
end