Timeline = Toruzou.module "Timeline"

class Timeline.Router extends Toruzou.Common.ResourceRouter
  resource: ""
  appRoutes:
    "": "index"

API =
  index: ->
    Timeline.Index.Controller.list()

Toruzou.addInitializer -> new Timeline.Router controller: API
