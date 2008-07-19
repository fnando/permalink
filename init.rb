require "has_permalink"
ActiveRecord::Base.send(:include, SimplesIdeias::Acts::Permalink)