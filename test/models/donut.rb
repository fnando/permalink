class Donut < ActiveRecord::Base
  has_permalink :flavor => :slug, :to_param => [:slug, :id, 'permalink']
end