Show = Toruzou.module "Organizations.Show"

Show.Controller =
  
  show: (id, slug) ->
    $.when(Toruzou.request "organization:fetch", id).done (organization) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      view = new Show.View model: organization
      layout.mainRegion.show view
      if slug
        view.show slug
      else
        view.showUpdates()
