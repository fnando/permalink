class Person
  include Mongoid::Document
  field :name

  permalink :name, :to => :permalink, :to_param => [:id, "    ", nil, "\t", :permalink]
end
