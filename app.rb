# -*- coding: utf-8 -*-

require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'slim'
require './models/rss'
require './models/entry'

class App < Sinatra::Base
  enable :method_override

  use Rack::Auth::Basic do |username, password|
    [username, password] == [ENV['BASIC_USERNAME'], ENV['BASIC_PASSWORD']]
  end


  @config = {}
  @config[:env]  = ENV['RACK_ENV'] || 'development'
  @config[:root] = File.dirname __FILE__
  @config[:database] = \
    if ENV.has_key?('DATABASE_URL')
      ENV['DATABASE_URL'] + '?reconnect=true&pool=10&timeout=5000'
    else
      filepath  = File.join @config[:root], 'config/database.yml'
      databases = YAML.load_file filepath
      databases[@config[:env]]
    end

  ActiveRecord::Base.establish_connection(@config[:database])

  before do
    @rsses = Rss.all
  end

  get '/' do
    redirect '/rsses'
  end

  get '/rsses' do
    @rss = Rss.new
    slim :'rsses/index'
  end

  post '/rsses' do
    @rss = Rss.new params[:rss]
    if @rss.save
      redirect '/rsses'
    else
      slim :'rsses/index'
    end
  end

  get '/rsses/:id/edit' do
    @rss = Rss.find(params[:id])
    slim :'rsses/index'
  end

  put '/rsses/:id' do
    @rss = Rss.find(params[:id])
    if @rss.update_attributes params[:rss]
      redirect '/rsses'
    else
      slim :'rsses/index'
    end
  end

  delete '/rsses/:id' do
    @rss = Rss.find(params[:id])
    @rss.destroy
    redirect '/rsses'
  end

end

