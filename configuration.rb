# -*- coding: utf-8 -*-
require 'singleton'
require 'uri'

class Configuration
  include Singleton

  def initialize
  end

  def env
    ENV['RACK_ENV'] || 'development'
  end

  def use_basic_auth
    self.basic_auth[:username] && self.basic_auth[:password]
  end

  def basic_auth
    {
      :username => ENV['BASIC_USERNAME'],
      :password => ENV['BASIC_PASSWORD']
    }
  end

  def database_url
    database_url = ENV['DATABASE_URL'] || \
      "sqlite3:///#{self}/db/#{self.env}.sqlite3"
    database_url + "?reconnection=true&pool=5&timeout=5000"
  end

end

