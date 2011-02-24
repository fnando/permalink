class User < ActiveRecord::Base
  permalink :name, :to => :permalink, :to_param => [:id, "    ", nil, "\t", :permalink]
end
