Index = Toruzou.module "Timeline.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "notifications:fetch").done (notifications) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show new Index.View collection: notifications
    