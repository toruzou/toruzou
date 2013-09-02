Toruzou.module "People.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showPeople: (id) ->
      $.when(Toruzou.request "person:fetch", id).done (people) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        layout.mainRegion.show(new Show.View model: people)
      