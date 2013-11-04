Index = Toruzou.module "Users.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "users:fetch").done (users) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: users)
    