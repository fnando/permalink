# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "permalink/version"

Gem::Specification.new do |s|
  s.name        = "permalink"
  s.version     = Permalink::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/permalink"
  s.summary     = "Generate permalink attributes on ActiveRecord"
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "activerecord"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_development_dependency "mongoid", "~> 2.0.0.rc.7"
  s.add_development_dependency "mongo_mapper", "~> 0.8.6"
  s.add_development_dependency "bson_ext"
  s.add_development_dependency "ruby-debug19" if RUBY_VERSION >= "1.9"
end
