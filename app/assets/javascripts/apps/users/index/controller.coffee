Toruzou.module "Users.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  Index.Controller =
    
    listUsers: ->
      $.when(Toruzou.request "users:fetch").done (users) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        layout.mainRegion.show(new Index.View collection: users)
      