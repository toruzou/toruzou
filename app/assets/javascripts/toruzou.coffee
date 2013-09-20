root = exports ? this
Toruzou = root.Toruzou = new Marionette.Application()
  
Toruzou.Configuration =
  root: "/"
  api:
    version: "v1"

Toruzou.linkTo = (relative) ->
  root = Toruzou.Configuration.root 
  "#{root}#{relative}"

Toruzou.navigate = (route, options) ->
  options or= {}
  Backbone.history.navigate(route, options)
