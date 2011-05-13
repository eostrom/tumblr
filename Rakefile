begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'tumblr'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tumblr-rb"
    gem.summary = "Ruby wrapper and command line interface to the Tumblr API."
    gem.description = "Ruby library and command line utility to work with the Tumblr Blogging Platform, powered by Weary."
    gem.version = Tumblr::VERSION
    gem.email = "mark@markwunsch.com"
    gem.homepage = "http://github.com/mwunsch/tumblr"
    gem.authors = ["Mark Wunsch"]
    gem.add_development_dependency "bundler", ">= 0.9.19"
    gem.test_files = [ "test/helper.rb", "test/test_tumblr.rb" ]
    gem.rdoc_options = ["--charset=UTF-8"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tumblr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r tumblr"
end

desc "Build the manual"
task :build_man do
  sh "ronn -br5 --organization='Mark Wunsch' --manual='Tumblr Manual' man/*.ronn"
end
 
desc "Show the manual"
task :man => :build_man do
  exec "man man/tumblr.1"
end
