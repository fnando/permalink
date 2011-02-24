class Cookie
  include Mongoid::Document
  field :flavor
  field :slug

  permalink :flavor, :to => :slug, :to_param => [:slug, :id, 'permalink']
end
