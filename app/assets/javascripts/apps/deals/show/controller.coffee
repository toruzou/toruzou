Show = Toruzou.module "Deals.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "deal:fetch", id).done (deal) ->
      view = new Show.View model: deal
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()

    