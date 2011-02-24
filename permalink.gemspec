# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "permalink/version"

Gem::Specification.new do |s|
  s.name        = "permalink"
  s.version     = Permalink::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://github.com/fnando/permalink"
  s.summary     = %q{ActiveRecord and Mongoid plugin for automatically converting fields to permalinks.}

  s.rubyforge_project = "permalink"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = %q{1.3.7}
  s.extra_rdoc_files = [
    "README.markdown"
  ]

  s.add_development_dependency "rails"
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_development_dependency "rspec-rails", "~> 2.5.0"
  s.add_development_dependency "sqlite3-ruby"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
