source "https://rubygems.org"
ruby "2.0.0"

gem "therubyracer", :platforms => :ruby
gem "rails", "4.0.0"
gem "pg"

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'handlebars_assets', '>= 0.14.1'
gem 'compass-rails', '>= 2.0.0'
gem 'zurb-foundation', '>= 4.3.1'
gem 'font-awesome-rails', '~> 3.2.1.3'
gem 'sprockets', '2.11.0'

gem "devise", "~> 3.0.3"
gem "kaminari", "~> 0.14.1"
gem "active_model_serializers", "~> 0.8.1"
gem "carrierwave", "~> 0.9.0"
gem "carrierwave-postgresql", "~> 0.1.1"
gem "paranoia", "~> 2.0.1"
gem "auditable", github: "harleyttd/auditable", branch: "master"
gem "rails-settings-cached", "0.3.1"

group :doc do
  gem "yard"
  gem "sdoc", require: false
end

group :development, :test do
  gem 'spring'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-coolline'
  gem 'pry-rails'
end

# Local Testing Tools
group :development, :test do
  gem "growl"
  gem "guard"
  gem "rspec-rails", "~>2.14.0"
  gem "json_spec", "1.1.1"
  gem "guard-rspec"
  gem "guard-spork"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "spork", "1.0.0rc3"
end

group :production do
  gem "rails_12factor"
end
