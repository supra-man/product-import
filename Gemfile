# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.6.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'pg', '~> 1.4', '>= 1.4.6'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'active_model_serializers', '~> 0.10.13'
gem 'annotate'
gem 'aws-sdk-s3', '~> 1.121'
gem 'graphql'
gem 'graphql-ruby'
gem 'image_processing', '~> 1.2'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'net-http'
gem 'ruby-vips', '~> 2.1', '>= 2.1.4'
gem 'sidekiq', '~>6.5.1'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot', '~> 6.2', '>= 6.2.1'
  gem 'faker', '~> 3.2'
  gem 'pry', '~> 0.14.2'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :test do
  gem 'rspec-sidekiq', '~> 3.1'
end
group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
