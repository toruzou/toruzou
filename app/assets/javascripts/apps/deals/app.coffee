Deals = Toruzou.module "Deals"

class Deals.Router extends Toruzou.Common.ResourceRouter
  resource: "deals"
  appRoutes:
    "": "list"
    "/new": "new"
    "/:id/edit": "edit"
    "/:id(/*slug)": "show"

API =
  list: ->
    Deals.Index.Controller.list()
  new: ->
    Deals.New.Controller.show()
  create: (deal) ->
    Deals.New.Controller.show deal
  edit: (id) ->
    Deals.Edit.Controller.show id
  show: (id, slug) ->
    Deals.Show.Controller.show id, slug

Toruzou.commands.setHandler "show:deals:create", (deal) ->
  Toruzou.execute "navigate:deals:new"
  API.create deal

Toruzou.addInitializer -> new Deals.Router controller: API
