# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'faker', '~> 3.2'
gem 'figaro', '~> 1.2'
gem 'jwt', '~> 2.8'
gem 'mysql2', '~> 0.5'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'
gem 'simplecov', '~> 0.22.0'

# gem 'jbuilder'

# gem 'redis', '>= 4.0.1'

# gem 'kredis'

# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# gem 'image_processing', '~> 1.2'

# gem 'rack-cors'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', require: false
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end
