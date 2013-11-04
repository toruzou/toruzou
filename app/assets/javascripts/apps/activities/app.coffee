Activities = Toruzou.module "Activities"

Activities.Router = class ActivitiesRouter extends Toruzou.Common.ResourceRouter
  resource: "activities"
  appRoutes:
    "": "list"

API =
  list: ->
    Activities.Index.Controller.list()

Toruzou.addInitializer -> new Activities.Router controller: API
