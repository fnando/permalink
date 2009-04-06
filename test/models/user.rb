class User < ActiveRecord::Base
  has_permalink :name, :to => :permalink, :to_param => [:id, "    ", nil, "\t", :permalink]
end