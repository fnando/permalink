# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{permalink}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nando Vieira"]
  s.date = %q{2010-07-09}
  s.email = %q{fnando.vieira@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "Rakefile",
     "init.rb",
     "lib/permalink.rb",
     "lib/permalink/string_ext.rb",
     "lib/permalink/version.rb",
     "test/models/beer.rb",
     "test/models/donut.rb",
     "test/models/post.rb",
     "test/models/user.rb",
     "test/permalink_test.rb",
     "test/schema.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/fnando/has_permalink}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{ActiveRecord plugin for automatically converting fields to permalinks.}
  s.test_files = [
    "test/models/beer.rb",
     "test/models/donut.rb",
     "test/models/post.rb",
     "test/models/user.rb",
     "test/permalink_test.rb",
     "test/schema.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

