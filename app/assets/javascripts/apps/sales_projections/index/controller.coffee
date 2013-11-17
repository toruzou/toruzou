Index = Toruzou.module "SalesProjections.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "salesProjections:fetch").done (salesProjections) ->
      Toruzou.mainRegion.show(new Index.View collection: salesProjections)
      Toruzou.execute "set:layout", "application"
    