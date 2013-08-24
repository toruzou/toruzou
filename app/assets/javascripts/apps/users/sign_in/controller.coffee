Toruzou.module "Users.SignIn", (SignIn, Toruzou, Backbone, Marionette, $, _) ->

  SignIn.Controller =
    show: ->
      layout = Toruzou.Common.UnauthenticatedLayout.show()
      layout.mainRegion.show new SignIn.View()
      