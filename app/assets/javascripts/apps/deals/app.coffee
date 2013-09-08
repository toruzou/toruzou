Toruzou.module "Deals", (Deals, Toruzou, Backbone, Marionette, $, _) ->

  Deals.Router = class DealsRouter extends Marionette.AppRouter
    appRoutes:
      "deals": "listDeals"
      "deals/:id": "showDeal"
      "deals/:id/*slug": "showDeal"

  API =
    listDeals: ->
      Deals.Index.Controller.listDeals()
    showDeal: (id, slug) ->
      Deals.Show.Controller.showDeal id, slug

  Toruzou.on "deals:list", ->
    Toruzou.navigate "deals"
    API.listDeals()

  Toruzou.on "deal:sectionChanged", (options) ->
    Toruzou.navigate "deals/#{options.id}/#{options.slug}"

  Toruzou.addInitializer -> new Deals.Router controller: API
