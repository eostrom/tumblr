begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

require 'pp'
require 'test/unit'
require 'contest'
require 'vcr'
require 'fakeweb'
# Ruby 1.9 does not like redgreen
begin
  require 'redgreen'
rescue LoadError
end

begin
  require 'tumblr'
rescue LoadError
  lib_path = File.join(File.dirname(__FILE__), '..', 'lib')
  $LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
  require 'tumblr'
end

FakeWeb.allow_net_connect = false

VCR.config do |c|
  # the cache_dir is where the cassette yml files will be saved.
  c.cassette_library_dir = File.join(File.dirname(__FILE__),'fixtures', 'vcr_cassettes')

  # this record mode will be used for any cassette you create without specifying a record mode.
  c.default_cassette_options = {:record => :none}

  # use FakeWeb for stubbing
  c.stub_with :fakeweb
end

def hijack!(request, fixture)
  record_mode = File.exist?(VCR::Cassette.new(fixture).file) ? :none : :unregistered
  VCR.use_cassette(fixture, :record => record_mode) do
    request.perform
  end
end
