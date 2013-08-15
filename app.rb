# -*- coding: utf-8 -*-
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'slim'
require "#{File.dirname(__FILE__)}/helper_methods"
Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |file| require file }

class App < Sinatra::Base
  include HelperMethods

  init

  ActiveRecord::Base.establish_connection

  basic_auth_filter

  enable :method_override

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

