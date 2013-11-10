Activities = Toruzou.module "Activities"

class Activities.Router extends Toruzou.Common.ResourceRouter
  resource: "activities"
  appRoutes:
    "": "list"
    "/new": "new"
    "/:id/edit": "edit"
    "/:id(/*slug)": "show"

API =
  list: ->
    Activities.Index.Controller.list()
  new: ->
    Activities.New.Controller.show()
  create: (activity) ->
    Activities.New.Controller.show activity
  edit: (id) ->
    Activities.Edit.Controller.show id
  show: (id, slug) ->
    Activities.Show.Controller.show id, slug

Toruzou.commands.setHandler "show:activities:create", (activity) ->
  Toruzou.execute "navigate:activities:new"
  API.create activity
  
Toruzou.addInitializer -> new Activities.Router controller: API
