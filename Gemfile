source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap_form'
#gem 'wdm', '>= 0.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'bcrypt', platforms: :ruby
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#jqueryui
gem 'jquery-ui-rails'

#gem service worker for web push notifications
gem 'serviceworker-rails'
gem "webpush"
gem 'sprockets-rails', :require => 'sprockets/railtie'


#fullCalendar
gem 'fullcalendar-rails'
gem 'momentjs-rails'
#DateTimePicker
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
#Faker
gem 'faker'

#mandrill-api
gem 'mandrill-api'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
#WINDOWS Gems That don't play well with nix
platforms :mswin do
  gem "wdm", :group => [:development, :test]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


#ldap
#gem 'net-ldap', '~> 0.3.1'
gem "devise"
gem "devise_ldap_authenticatable"

gem 'will_paginate', '~> 3.1.0'
gem 'carrierwave', '~> 0.10.0'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'mini_magick'

#Charts
gem "chartkick"
gem 'groupdate'
gem 'active_median', '~> 0.1.0'
