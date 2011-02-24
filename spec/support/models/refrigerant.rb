class Refrigerant
  include Mongoid::Document
  field :name

  permalink :name, :to_param => [:id, :permalink]
end
