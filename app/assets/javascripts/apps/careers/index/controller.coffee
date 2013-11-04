Index = Toruzou.module "Careers.Index"

Index.Controller =
  
  listCareers: ->
    $.when(Toruzou.request "careers:fetch").done (careers) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: careers)
    