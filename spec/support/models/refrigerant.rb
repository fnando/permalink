class Refrigerant
  include Mongoid::Document
  field :name

  permalink :name
end
