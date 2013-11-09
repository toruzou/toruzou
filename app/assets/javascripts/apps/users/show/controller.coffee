Show = Toruzou.module "Users.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "user:fetch", id).done (user) ->
      view = new Show.View model: user
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()

    