source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'unicorn'
gem 'figaro'
gem 'simplecov', :require => false, :group => :test
gem 'faraday'
gem 'responders', '~> 2.0'
gem "selenium-webdriver"
gem 'fastimage'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
  gem 'capybara'
  gem "capybara-webkit"
  gem 'launchy'
  gem 'byebug'
  gem 'pry-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'show_me_the_cookies'
  gem "database_cleaner"
end

group :production do
  gem 'rails_12factor'
end
