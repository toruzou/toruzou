Toruzou.module "Users.SignUp", (SignUp, Toruzou, Backbone, Marionette, $, _) ->

  SignUp.Controller =
    show: ->
      layout = new Toruzou.Users.Common.UnauthenticatedLayout()
      view = new SignUp.View()
      layout.on "show", -> layout.mainRegion.show view
      Toruzou.mainRegion.show layout
      