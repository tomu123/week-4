# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Generates real-looking test data
  gem 'faker', '~> 2.20'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Add support to load environment variables from `.env` files.
  gem 'dotenv-rails', '~> 2.7'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Add Code Linter and Formatter Rubocop which works according to Ruby Style Guide and configured by rubocop.yml
  gem 'rubocop', '~> 1.26', require: false
end

group :test do
  # Helper for writing factories for Ruby tests
  gem 'factory_bot_rails', '~> 6.2'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Adds support for user authentication
gem 'devise', '~> 4.8'

# Adds support to easily create and design forms
gem 'simple_form', '~> 5.1'

# Representable maps objects to documents (rendering) and documents to objects (parsing) using representers.
gem 'representable', '~> 3.1'

# Representable Dependency for JSON documents
gem 'multi_json', '~> 1.15'

# Add support for Pagination
gem 'pagy', '~> 5.10'

# Add support for RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt', '~> 2.3'

gem 'swagger-blocks', '~> 3.0'

# Add support for Google Cloud Storage
gem 'google-cloud-storage', '~> 1.36', require: false

# Add support for using ActiveJob with SideKiq as queing backend
gem 'sidekiq', '~> 6.4'
gem 'sidekiq-failures', '~> 1.0'

# Add support for payment using Stripe
gem 'stripe', '~> 5.53'
