Index = Toruzou.module "Users.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "users:fetch").done (users) ->
      Toruzou.mainRegion.show(new Index.View collection: users)
      Toruzou.execute "set:layout", "application"
    