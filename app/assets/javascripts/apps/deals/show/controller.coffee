Toruzou.module "Deals.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showDeal: (id, slug) ->
      $.when(Toruzou.request "deal:fetch", id).done (deal) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        view = new Show.View model: deal
        layout.mainRegion.show view
        if slug
          view.show slug
        else
          view.showUpdates()

      