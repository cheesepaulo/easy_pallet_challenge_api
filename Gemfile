source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Rack middleware for blocking & throttling abusive requests
gem 'rack-attack'
# Serializer json
gem 'active_model_serializers'

group :test do
  # Strategies for cleaning databases in Ruby.
  gem 'database_cleaner-active_record'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  gem 'pry-byebug'
  # Testing framework
  gem 'rspec-rails', '~> 4.0.0.rc1'
  # Fabricate model data
  gem 'factory_bot_rails'
  # Generate faker data
  gem 'ffaker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Rails console open pry.
  gem 'pry-rails'
  # Automatized deploy
  gem "capistrano", "~> 3.12", require: false
  gem 'capistrano-rvm',              require: false
  gem 'capistrano-rails',            require: false
  gem 'capistrano-bundler',          require: false
  gem 'capistrano3-puma',            require: false
  gem 'capistrano-rails-collection', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
