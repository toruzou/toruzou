SignIn = Toruzou.module "Users.SignIn"

SignIn.Controller =
  show: ->
    Toruzou.mainRegion.show new SignIn.View()
    Toruzou.execute "set:layout", "unauthenticated"
    