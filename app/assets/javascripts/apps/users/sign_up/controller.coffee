Toruzou.module "Users.SignUp", (SignUp, Toruzou, Backbone, Marionette, $, _) ->

  SignUp.Controller =
    show: ->
      layout = Toruzou.Common.UnauthenticatedLayout.show()
      layout.mainRegion.show new SignUp.View()
      