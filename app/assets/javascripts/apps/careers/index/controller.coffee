Toruzou.module "Careers.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  Index.Controller =
    
    listCareers: ->
      $.when(Toruzou.request "careers:fetch").done (careers) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        layout.mainRegion.show(new Index.View collection: careers)
      