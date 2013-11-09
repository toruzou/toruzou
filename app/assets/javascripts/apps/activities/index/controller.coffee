Index = Toruzou.module "Activities.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "activities:fetch").done (activities) ->
      Toruzou.mainRegion.show(new Index.View collection: activities)
      Toruzou.execute "set:layout", "application"
    