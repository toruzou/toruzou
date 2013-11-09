Show = Toruzou.module "Organizations.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "organization:fetch", id).done (organization) ->
      view = new Show.View model: organization
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()
