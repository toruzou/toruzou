SalesProjections = Toruzou.module "SalesProjections"

class SalesProjections.Router extends Toruzou.Common.ResourceRouter
  resource: "sales"
  appRoutes:
    "": "list"

API =
  list: ->
    SalesProjections.Index.Controller.list()
  
Toruzou.addInitializer -> new SalesProjections.Router controller: API
