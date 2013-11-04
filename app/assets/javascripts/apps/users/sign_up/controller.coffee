SignUp = Toruzou.module "Users.SignUp"

SignUp.Controller =
  show: ->
    layout = Toruzou.Common.UnauthenticatedLayout.show()
    layout.mainRegion.show new SignUp.View()
    