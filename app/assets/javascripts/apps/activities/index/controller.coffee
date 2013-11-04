Index = Toruzou.module "Activities.Index"

Index.Controller =
  
  listActivities: ->
    $.when(Toruzou.request "activities:fetch").done (activities) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: activities)
    