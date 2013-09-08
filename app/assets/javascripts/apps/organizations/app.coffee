Toruzou.module "Organizations", (Organizations, Toruzou, Backbone, Marionette, $, _) ->

  Organizations.Router = class OrganizationsRouter extends Marionette.AppRouter
    appRoutes:
      "organizations": "listOrganizations"
      "organizations/:id": "showOrganization"
      "organizations/:id/*slug": "showOrganization"

  API =
    listOrganizations: ->
      Organizations.Index.Controller.listOrganizations()
    showOrganization: (id, slug) ->
      Organizations.Show.Controller.showOrganization id, slug

  # TODO Remove following code
  Toruzou.on "authentication:signedIn", ->
    Toruzou.navigate "organizations"
    API.listOrganizations()

  Toruzou.on "organizations:list", ->
    Toruzou.navigate "organizations"
    API.listOrganizations()

  Toruzou.on "organization:sectionChanged", (options) ->
    Toruzou.navigate "organizations/#{options.id}/#{options.slug}"

  Toruzou.addInitializer -> new Organizations.Router controller: API
