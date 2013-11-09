Timeline = Toruzou.module "Timeline"

class Timeline.Router extends Toruzou.Common.ResourceRouter
  resource: "timeline"
  appRoutes:
    "": "list"

API =
  list: ->
    Timeline.Index.Controller.list()

Toruzou.addInitializer -> new Timeline.Router controller: API
