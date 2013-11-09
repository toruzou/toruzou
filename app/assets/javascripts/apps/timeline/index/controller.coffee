Index = Toruzou.module "Timeline.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "notifications:fetch").done (notifications) ->
      Toruzou.mainRegion.show new Index.View collection: notifications
      Toruzou.execute "set:layout", "application"
    