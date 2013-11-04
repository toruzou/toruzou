Index = Toruzou.module "Deals.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "deals:fetch").done (deals) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: deals)
    