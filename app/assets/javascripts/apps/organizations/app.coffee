Toruzou.module "Organizations", (Organizations, Toruzou, Backbone, Marionette, $, _) ->

  Organizations.Router = class OrganizationsRouter extends Marionette.AppRouter
    appRoutes:
      "organizations": "listOrganizations"

  API =
    listOrganizations: ->
      Organizations.Index.Controller.listOrganizations()

  # TODO Remove following code
  Toruzou.on "authentication:signed_in", ->
    Toruzou.navigate "organizations"
    API.listOrganizations()

  Toruzou.addInitializer -> new Organizations.Router controller: API
