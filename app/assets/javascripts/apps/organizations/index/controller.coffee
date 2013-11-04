Index = Toruzou.module "Organizations.Index"

Index.Controller =
  
  listOrganizations: ->
    $.when(Toruzou.request "organizations:fetch").done (organizations) ->
      layout = Toruzou.Common.ApplicationLayout.show()
      layout.mainRegion.show(new Index.View collection: organizations)
    