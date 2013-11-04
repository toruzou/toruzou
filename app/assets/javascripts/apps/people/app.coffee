People = Toruzou.module "People"

People.Router = class PeopleRouter extends Toruzou.Common.ResourceRouter
  resource: "people"
  appRoutes:
    "": "list"
    "/:id(/*slug)": "show"

API =
  list: ->
    People.Index.Controller.list()
  show: (id, slug) ->
    People.Show.Controller.show id, slug

Toruzou.addInitializer -> new People.Router controller: API
