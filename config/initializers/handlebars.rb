# Handlebars Integration
require 'sprockets'
env = Sprockets::Environment.new

require 'handlebars_assets'
HandlebarsAssets::Config.template_namespace = 'JST'
env.append_path HandlebarsAssets.path