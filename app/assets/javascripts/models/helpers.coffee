Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  Models.endpoint = (url) -> "api/#{Toruzou.Configuration.api.version}/#{url}"