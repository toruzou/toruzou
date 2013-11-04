Show = Toruzou.module "People.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "person:fetch", id).done (person) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      view = new Show.View model: person
      layout.mainRegion.show view
      if slug
        view.show slug
      else
        view.showUpdates()

    