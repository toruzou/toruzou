Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  Index.Controller =
    
    listPeople: ->
      $.when(Toruzou.request "people:fetch").done (people) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        layout.mainRegion.show(new Index.View collection: people)
      