SignUp = Toruzou.module "Users.SignUp"

SignUp.Controller =
  show: ->
    Toruzou.mainRegion.show new SignUp.View()
    Toruzou.execute "set:layout", "unauthenticated"
    