Toruzou.module "Users.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showUser: (id, slug) ->
      $.when(Toruzou.request "user:fetch", id).done (user) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        view = new Show.View model: user
        layout.mainRegion.show view
        if slug
          view.show slug
        else
          view.showUpdates()

      