# -*- coding: utf-8 -*-
require 'spec_helper'

describe App do

  let :app do
    described_class
  end

  before do
    @rss_params_list = [
      { :title => 'first rss',
        :url   => 'http://example.com/first/rss' },
      { :title => 'second rss',
        :url   => 'http://example.com/second/rss' } ]
  end

  context 'GET /' do
    it do
      get '/'
      location_uri = URI.parse last_response.headers['Location']
      expect(last_response).to be_redirect
      expect(location_uri.path).to eq '/rsses'
    end
  end

  context 'GET /rsses' do
    it do
      get '/rsses'
      expect(last_response).to be_ok
    end
  end

  context 'POST /rsses' do
    it do
      post '/rsses', :rss => @rss_params_list[0]
      expect(last_response).to be_redirect
    end
  end

  context 'GET /rsses/:id/edit' do
    it do
      @rss = Rss.create! @rss_params_list[0]
      get "/rsses/#{@rss.id}/edit"
      expect(last_response).to be_ok
    end
  end

  context 'PUT /rsses/:id' do
    it do
      @rss = Rss.create! @rss_params_list[0]
      put "/rsses/#{@rss.id}", :rss => @rss_params_list[1]
      expect(last_response).to be_redirect
    end
  end

  context 'DELETE /rsses/:id' do
    it do
      @rss = Rss.create! @rss_params_list[0]
      delete "/rsses/#{@rss.id}"
      expect(last_response).to be_redirect
    end
  end
end

