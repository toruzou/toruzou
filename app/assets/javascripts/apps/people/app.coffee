Toruzou.module "People", (People, Toruzou, Backbone, Marionette, $, _) ->

  People.Router = class PeopleRouter extends Marionette.AppRouter
    appRoutes:
      "people": "listPeople"
      "people/:id": "showPeople"

  API =
    listPeople: ->
      People.Index.Controller.listPeople()
    showPeople: (id) ->
      People.Show.Controller.showPeople id

  Toruzou.on "people:list", ->
    Toruzou.navigate "people"
    API.listPeople()

  Toruzou.addInitializer -> new People.Router controller: API
