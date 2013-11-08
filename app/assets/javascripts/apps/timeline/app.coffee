Timeline = Toruzou.module "Timeline"

Timeline.Router = class TimelineRouter extends Toruzou.Common.ResourceRouter
  resource: "timeline"
  appRoutes:
    "": "list"

API =
  list: ->
    Timeline.Index.Controller.list()

Toruzou.addInitializer -> new Timeline.Router controller: API
