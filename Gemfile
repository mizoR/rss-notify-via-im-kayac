source 'https://rubygems.org/'

ruby '2.0.0'

gem 'rake'
gem 'sinatra'
gem 'slim'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'feed-normalizer', :require => false
gem 'im-kayac'       , :require => false
gem 'clockwork'

group :production do
  gem 'pg'
end

group :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'rack-test'
end

group :development do
  gem 'sqlite3'
  gem 'heroku'
  gem 'foreman'
end

