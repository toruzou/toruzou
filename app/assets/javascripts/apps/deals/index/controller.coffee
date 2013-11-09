Index = Toruzou.module "Deals.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "deals:fetch").done (deals) ->
      Toruzou.mainRegion.show(new Index.View collection: deals)
      Toruzou.execute "set:layout", "application"
      