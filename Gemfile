source 'https://rubygems.org'

rubyVersion = "2.0"
if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new(rubyVersion)
  puts "You have to use Ruby #{rubyVersion}+ (Your version is #{RUBY_VERSION})"
  exit 1
end

# https://github.com/rails/rails/pull/11444
# gem 'rails', '4.0.0'
gem 'rails', git: 'https://github.com/inopinatus/rails', branch: 'hstore_arrays_fix'
gem 'pg'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'devise', '~> 3.0.3'
gem 'kaminari', '~> 0.14.1'
gem 'active_model_serializers', '~> 0.8.1'
gem 'carrierwave', '~> 0.9.0'
gem 'carrierwave-postgresql', '~> 0.1.1'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'spring'
  # gem "compass-rails", '>= 2.0.alpha.0'
  # https://github.com/rails/rails/pull/11444
  # https://github.com/Compass/compass-rails/pull/96
  gem 'compass-rails', github: "roderickvd/compass-rails", branch: "rails41"
  gem "zurb-foundation", '>= 4.3.1'
  gem "handlebars_assets", '>= 0.14.1'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-debugger'
  gem 'pry-coolline'
  gem 'pry-rails'
end

# Local Testing Tools
group :development, :test do
  gem 'growl'
  gem 'guard'
  gem 'rspec-rails', '~>2.14.0'
  gem 'json_spec', '1.1.1'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'spork', '1.0.0rc3'
end

# Documentation Tools
gem 'yard'
