Index = Toruzou.module "Deals.Index"

Index.Controller =
  
  listDeals: ->
    $.when(Toruzou.request "deals:fetch").done (deals) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: deals)
    