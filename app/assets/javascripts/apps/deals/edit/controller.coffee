Edit = Toruzou.module "Deals.Edit"

Edit.Controller =
  
  show: (id) ->
    $.when(Toruzou.request "deal:fetch", id).done (deal) ->
      Toruzou.mainRegion.show new Edit.View model: deal
      Toruzou.execute "set:layout", "application"
      