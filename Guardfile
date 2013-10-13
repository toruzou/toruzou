# More info at https://github.com/guard/guard#readme
require 'active_support/inflector'

guard 'spork', minitest: false, cucumber: false, test_unit: false, rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch('spec/controllers/controller_helpers.rb') { :rspec }
  watch(%r{features/support/}) { :cucumber }
  watch(%r{^spec/factories/(.*)\.rb$}) { :rspec }
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^app/controllers/api/v(.)/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[2]}_routing_spec.rb", "spec/#{m[3]}s/#{m[2]}_#{m[1]}_spec.rb", "spec/acceptance/#{m[2]}_spec.rb", "spec/#{m[3]}s/api/v#{m[1]}/#{m[2]}_#{m[3]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('spec/controllers/controller_helpers.rb')     { "spec/controllers" }
  watch(%r{^spec/factories/(.*)\.rb$})                { |m| ["spec/models/#{m[1].singularize}_spec.rb", "spec/controllers/#{m[1]}_controller_spec.rb", "spec/controllers/api/v1/#{m[1]}_controller_spec.rb"] }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end
