source 'https://rubygems.org'

rubyVersion = "2.0"
if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new(rubyVersion)
  puts "You have to use Ruby #{rubyVersion}+ (Your version is #{RUBY_VERSION})"
  exit 1
end

gem 'rails', '4.0.0'
gem 'pg'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'devise', '~> 3.0.3'
gem 'kaminari', '~> 0.14.1'
gem 'active_model_serializers', '~> 0.8.1'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'spring'
  gem "compass-rails", '>= 2.0.alpha.0'
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
