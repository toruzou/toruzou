Deals = Toruzou.module "Deals"

Deals.Router = class DealsRouter extends Toruzou.Common.ResourceRouter
  resource: "deals"
  appRoutes:
    "": "list"
    "/:id": "show"
    "/:id/*slug": "showContents"

API =
  list: ->
    Deals.Index.Controller.list()
  show: (id) ->
    Deals.Show.Controller.show id
  showContents: (id, slug) ->
    Deals.Show.Controller.show id, slug

Toruzou.addInitializer -> new Deals.Router controller: API
