class User < ActiveRecord::Base
  has_permalink :name => :permalink, :to_param => [:id, "    ", nil, "\t", :permalink]
end