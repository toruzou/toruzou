Toruzou.module "People.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showPerson: (id, slug) ->
      $.when(Toruzou.request "person:fetch", id).done (person) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        view = new Show.View model: person
        layout.mainRegion.show view
        view.show slug if slug
      