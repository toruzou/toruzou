Index = Toruzou.module "Organizations.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "organizations:fetch").done (organizations) ->
      Toruzou.mainRegion.show(new Index.View collection: organizations)
      Toruzou.execute "set:layout", "application"
    