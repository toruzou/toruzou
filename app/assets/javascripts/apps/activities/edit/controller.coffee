Edit = Toruzou.module "Activities.Edit"

Edit.Controller =
  
  show: (id) ->
    $.when(Toruzou.request "activity:fetch", id).done (activity) ->
      Toruzou.mainRegion.show new Edit.View model: activity
      Toruzou.execute "set:layout", "application"
      