Toruzou.module "Organizations", (Organizations, Toruzou, Backbone, Marionette, $, _) ->

  Organizations.Router = class OrganizationsRouter extends Marionette.AppRouter
    appRoutes:
      "organizations": "listOrganizations"
      "organizations/:id": "showOrganization"

  API =
    listOrganizations: ->
      Organizations.Index.Controller.listOrganizations()
    showOrganization: (id) ->
      Organizations.Show.Controller.showOrganization id

  # TODO Remove following code
  Toruzou.on "authentication:signed_in", ->
    Toruzou.navigate "organizations"
    API.listOrganizations()

  Toruzou.addInitializer -> new Organizations.Router controller: API
