source 'http://rubygems.org'

gem 'rack'
gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'mongoid'
gem 'mongoid_ext', git: 'git@github.com:kuadrosx/mongoid_ext.git', branch: 'mongoid5'
gem 'oj'
gem 'rack-cors', require: 'rack/cors'
gem 'rack-parser', require: 'rack/parser'

gem 'pry'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'

gem 'faraday'

group :test do
  gem 'fuubar'
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
  gem 'fabrication'
  gem 'ffaker'
  gem 'mongoid-tree' # database_cleaner dependency
  #gem 'database_cleaner', git: 'git@github.com:DatabaseCleaner/database_cleaner.git'
  gem 'database_cleaner-mongoid'
  gem 'timecop'
end
