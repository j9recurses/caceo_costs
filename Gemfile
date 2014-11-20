source 'https://rubygems.org'


gem 'therubyracer', platforms: :ruby

gem 'less-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'twitter-bootstrap-rails'
gem 'bootstrap-sass'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'activerecord-session_store'

group :test, :development, :production do
  gem 'rails'
  gem 'mysql2'
end

group :development, :production do
  gem 'hirb'
end

group :test do
  gem 'factory_girl_rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
end

group :test, :development do
  gem 'rspec-rails'
end


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


#gem 'less-rails-bootstrap'

#gem to vallidate email address
gem 'email_validator'

#gem for password salts
#gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'bcrypt-ruby', '~> 3.0.0', :require => "bcrypt"


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'nokogiri'

gem 'json'


#helps handle static mapping data- used for the ca county info
gem 'static_model'
gem 'simple_form', '3.0'


gem "letter_opener", :group => :development

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
