Show = Toruzou.module "People.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "person:fetch", id).done (person) ->
      view = new Show.View model: person
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()

    