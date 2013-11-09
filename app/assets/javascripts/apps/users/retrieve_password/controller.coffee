RetrievePassword = Toruzou.module "Users.RetrievePassword"

RetrievePassword.Controller =
  show: ->
    Toruzou.mainRegion.show new RetrievePassword.View()
    Toruzou.execute "set:layout", "unauthenticated"
    