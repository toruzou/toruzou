Organizations = Toruzou.module "Organizations"

Organizations.Router = class OrganizationsRouter extends Toruzou.Common.ResourceRouter
  resource: "organizations"
  appRoutes:
    "": "list"
    "/:id": "show"
    "/:id/*slug": "showContents"

API =
  list: ->
    Organizations.Index.Controller.list()
  show: (id) ->
    Organizations.Show.Controller.show id
  showContents: (id, slug) ->
    Organizations.Show.Controller.show id, slug

Toruzou.addInitializer -> new Organizations.Router controller: API
