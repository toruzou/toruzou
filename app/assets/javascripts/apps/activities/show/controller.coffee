Show = Toruzou.module "Activities.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "activity:fetch", id).done (activity) ->
      view = new Show.View model: activity
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()
