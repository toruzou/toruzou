Toruzou.module "People", (People, Toruzou, Backbone, Marionette, $, _) ->

  People.Router = class PeopleRouter extends Marionette.AppRouter
    appRoutes:
      "people": "listPeople"
      "people/:id": "showPerson"
      "people/:id/*slug": "showPerson"

  API =
    listPeople: ->
      People.Index.Controller.listPeople()
    showPerson: (id, slug) ->
      People.Show.Controller.showPerson id, slug

  Toruzou.on "people:list", ->
    Toruzou.navigate "people"
    API.listPeople()

  Toruzou.on "person:sectionChanged", (options) ->
    Toruzou.navigate "people/#{options.id}/#{options.slug}"

  Toruzou.addInitializer -> new People.Router controller: API
