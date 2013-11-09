Organizations = Toruzou.module "Organizations"

class Organizations.Router extends Toruzou.Common.ResourceRouter
  resource: "organizations"
  appRoutes:
    "": "list"
    "/:id(/*slug)": "show"

API =
  list: ->
    Organizations.Index.Controller.list()
  show: (id, slug) ->
    Organizations.Show.Controller.show id, slug

Toruzou.addInitializer -> new Organizations.Router controller: API
