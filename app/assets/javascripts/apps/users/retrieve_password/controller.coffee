Toruzou.module "Users.RetrievePassword", (RetrievePassword, Toruzou, Backbone, Marionette, $, _) ->

  RetrievePassword.Controller =
    show: ->
      layout = new Toruzou.Users.Common.UnauthenticatedLayout()
      view = new RetrievePassword.View()
      layout.on "show", -> layout.mainRegion.show view
      Toruzou.mainRegion.show layout
      