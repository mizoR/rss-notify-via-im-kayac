# -*- coding: utf-8 -*-

module HelperMethods
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def init
      ENV['DATABASE_URL'] ||= "sqlite3:///#{root}/db/#{environment}.sqlite3"
      self
    end

    def basic_auth_filter
      username, password = ENV['BASIC_USERNAME'], ENV['BASIC_PASSWORD']
      use Rack::Auth::Basic do |u, p|
        [username, password] == [u, p]
      end if username && password
    end
    private :basic_auth_filter

  end

end
