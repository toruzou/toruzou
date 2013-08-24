Toruzou.module "Users.SignIn", (SignIn, Toruzou, Backbone, Marionette, $, _) ->

  SignIn.Controller =
    show: ->
      layout = new Toruzou.Common.UnauthenticatedLayout()
      view = new SignIn.View
      layout.on "show", -> layout.mainRegion.show view
      Toruzou.mainRegion.show layout
      