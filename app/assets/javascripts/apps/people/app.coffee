People = Toruzou.module "People"

People.Router = class PeopleRouter extends Toruzou.Common.ResourceRouter
  resource: "people"
  appRoutes:
    "": "list"
    "/:id": "show"
    "/:id/*slug": "showContents"

API =
  list: ->
    People.Index.Controller.list()
  show: (id) ->
    People.Show.Controller.show id
  showContents: (id, slug) ->
    People.Show.Controller.show id, slug

Toruzou.addInitializer -> new People.Router controller: API
