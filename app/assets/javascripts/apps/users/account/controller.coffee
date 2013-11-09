Account = Toruzou.module "Users.Account"

Account.Controller =
  show: (slug) ->
    $.when(Toruzou.request "account:fetch").done (account) ->
      view = new Account.View model: account
      Toruzou.mainRegion.show view
      Toruzou.execute "set:layout", "application"
      if slug
        view.show slug
      else
        view.showUpdates()
    