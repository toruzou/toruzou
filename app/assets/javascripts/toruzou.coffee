root = exports ? this
Toruzou = root.Toruzou = new Marionette.Application()
  
Toruzou.Configuration =
  root: "/toruzou"
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

Toruzou.getCurrentRoute = ->
  Backbone.history.fragment

Toruzou.linkTo = (relative = "") ->
  root = Toruzou.Configuration.root 
  if root is "/" then "#{root}#{relative}" else "#{root}/#{relative}"

Toruzou.location = (relative = "") ->
  window.location = "#{location.protocol}//#{location.host}#{Toruzou.linkTo relative}"

Toruzou.navigate = (route, options = {}) ->
  root = Toruzou.Configuration.root
  route = route.replace root, "" if _.str.startsWith route, root
  Backbone.history.navigate route, options
