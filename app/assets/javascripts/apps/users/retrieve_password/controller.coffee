RetrievePassword = Toruzou.module "Users.RetrievePassword"

RetrievePassword.Controller =
  show: ->
    layout = Toruzou.Common.UnauthenticatedLayout.show()
    layout.mainRegion.show new RetrievePassword.View()
