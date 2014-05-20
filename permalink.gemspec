require "./lib/permalink/version"

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
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
