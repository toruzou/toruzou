Activities = Toruzou.module "Activities"

Activities.Router = class ActivitiesRouter extends Marionette.AppRouter
  appRoutes:
    "activities": "listActivities"

API =
  listActivities: ->
    Activities.Index.Controller.listActivities()

Toruzou.on "activities:list", ->
  Toruzou.navigate "activities"
  API.listActivities()

Toruzou.addInitializer -> new Activities.Router controller: API
