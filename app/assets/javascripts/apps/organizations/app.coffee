Organizations = Toruzou.module "Organizations"

Organizations.Router = class OrganizationsRouter extends Toruzou.Common.ResourceRouter
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
