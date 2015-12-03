source 'https://rubygems.org'


gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'autoprefixer-rails'
gem 'sprockets-rails', '~> 2.2.2'
gem 'bootstrap-sass'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'activerecord-session_store'

group :test, :development, :production do
  gem 'rails', '~> 4.2.1'
  gem 'mysql2'
  gem 'axlsx'
  gem 'axlsx_rails'
  gem 'simple_form', '~> 3.1'
  gem 'turbolinks', '~> 2.5.3'
  gem 'reform', git: 'git@github.com:sethdn/reform.git', branch: 'anonymous-form-names'
  gem 'active_model_serializers', '~>0.10.0.rc2'
end

group :development, :production do
  gem 'hirb'
  gem 'autonumeric-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'capybara'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
end

group :linux do
  gem 'rb-inotify'
end

group :test, :development do
  gem 'rspec-rails'  
end

# group :development do
#   gem 'nokogiri'
# end


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


#gem 'less-rails-bootstrap'

#gem to vallidate email address
gem 'email_validator'

#gem for password salts
#gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'bcrypt-ruby', '~> 3.0.0', :require => "bcrypt"


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'json'



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
