SignIn = Toruzou.module "Users.SignIn"

SignIn.Controller =
  show: ->
    layout = Toruzou.Common.UnauthenticatedLayout.show()
    layout.mainRegion.show new SignIn.View()
    