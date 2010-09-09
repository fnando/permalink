require "rake/testtask"
require File.dirname(__FILE__) + "/lib/permalink/version"

desc "Default: run unit tests."
task :default => :test

desc "Test the i18n-js plugin."
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

begin
  require "jeweler"

  JEWEL = Jeweler::Tasks.new do |gem|
    gem.name = "permalink"
    gem.email = "fnando.vieira@gmail.com"
    gem.homepage = "http://github.com/fnando/has_permalink"
    gem.authors = ["Nando Vieira"]
    gem.version = SimplesIdeias::Permalink::Version::STRING
    gem.summary = "ActiveRecord plugin for automatically converting fields to permalinks."
    gem.files =  FileList["README.markdown", "init.rb", "{lib,test}/**/*", "Rakefile"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError => e
  puts "[JEWELER] You can't build a gem until you install jeweler with `gem install jeweler`"
end
