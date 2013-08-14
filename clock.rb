# -*- coding: utf-8 -*-

require './app'
require 'sinatra/activerecord/rake'
require 'feed-normalizer'
require 'im-kayac'
require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
  username = ENV.has_key?('IM_KAYAC_USERNAME') ? \
    ENV['IM_KAYAC_USERNAME'] : raise(ArgumentError)
  password = ENV.has_key?('IM_KAYAC_PASSWORD') && ENV['IM_KAYAC_PASSWORD']
  secret   = ENV.has_key?('IM_KAYAC_SECRET')   && ENV['IM_KAYAC_SECRET']

  Rss.find_each do |rss|
    feed = FeedNormalizer::FeedNormalizer.parse open(rss.url)
    feed.entries.each do |entry|
      entry = rss.entries.build(
        :url     => entry.url,
        :title   => entry.title,
        :content => entry.content
      )
      case
      when Entry.exists?(:url => entry.url)
        # to nothing
      when !entry.save
        # save error
      when secret
        ImKayac.to(username).handler(entry.url).secret(secret).post(entry.title)
      when password
        ImKayac.to(username).handler(entry.url).password(password).post(entry.title)
      end
    end
  end
end

every(10.minutes, 'im_kayac:notify')

