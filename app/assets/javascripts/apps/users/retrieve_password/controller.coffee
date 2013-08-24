Toruzou.module "Users.RetrievePassword", (RetrievePassword, Toruzou, Backbone, Marionette, $, _) ->

  RetrievePassword.Controller =
    show: ->
      layout = Toruzou.Common.UnauthenticatedLayout.show()
      layout.mainRegion.show new RetrievePassword.View()
