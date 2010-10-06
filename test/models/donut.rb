class Donut < ActiveRecord::Base
  permalink :flavor, :to => :slug, :to_param => [:slug, :id, 'permalink']
end