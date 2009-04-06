class Donut < ActiveRecord::Base
  has_permalink :flavor, :to => :slug, :to_param => [:slug, :id, 'permalink']
end