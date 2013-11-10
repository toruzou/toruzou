New = Toruzou.module "Activities.New"

New.Controller =
  
  show: (activity) ->
    activity or= Toruzou.request("activity:new")
    Toruzou.mainRegion.show new New.View model: activity
    Toruzou.execute "set:layout", "application"
