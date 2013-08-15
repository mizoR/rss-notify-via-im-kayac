# -*- coding: utf-8 -*-
ENV['RACK_ENV'] ||= 'test'

require 'rspec'
require 'rack/test'
require "#{File.dirname(__FILE__)}/../app"

RSpec::configure do |config|
  include Rack::Test::Methods

  config.after do
    Entry.delete_all
    Rss.delete_all
  end
end
