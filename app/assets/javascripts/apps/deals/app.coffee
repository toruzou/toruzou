Deals = Toruzou.module "Deals"

class Deals.Router extends Toruzou.Common.ResourceRouter
  resource: "deals"
  appRoutes:
    "": "list"
    "/:id(/*slug)": "show"

API =
  list: ->
    Deals.Index.Controller.list()
  show: (id, slug) ->
    Deals.Show.Controller.show id, slug

Toruzou.addInitializer -> new Deals.Router controller: API
