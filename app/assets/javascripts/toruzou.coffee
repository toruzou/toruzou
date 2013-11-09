root = exports ? this
Toruzou = root.Toruzou = new Marionette.Application()
  
Toruzou.Configuration =
  root: "/"
  api:
    version: "v1"
  timeout: 5000
  # TODO commands
  routes:
    "User": "users"
    "Organization": "organizations"
    "Person": "people"
    "Deal": "deals"
    "Activity": "activities"
  # TODO refactoring
  bundles:
    actions:
      "create": "added"
      "update": "edited"
      "destroy": "deleted"
      "restore": "restored"

Toruzou.linkTo = (relative = "") ->
  root = Toruzou.Configuration.root 
  "#{root}#{relative}"

Toruzou.location = (relative = "") ->
  window.location = "#{location.protocol}//#{location.host}#{Toruzou.linkTo relative}"

Toruzou.navigate = (route, options) ->
  options or= {}
  Backbone.history.navigate(route, options)
