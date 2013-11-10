New = Toruzou.module "Deals.New"

New.Controller =
  
  show: (deal) ->
    deal or= Toruzou.request("deal:new")
    Toruzou.mainRegion.show new New.View model: deal
    Toruzou.execute "set:layout", "application"
