Index = Toruzou.module "People.Index"

Index.Controller =
  
  list: ->
    $.when(Toruzou.request "people:fetch").done (people) ->
      Toruzou.mainRegion.show(new Index.View collection: people)
      Toruzou.execute "set:layout", "application"
    