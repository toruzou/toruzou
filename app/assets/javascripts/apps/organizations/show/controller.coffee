Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showOrganization: (id) ->
      $.when(Toruzou.request "organization:fetch", id).done (organization) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        layout.mainRegion.show(new Show.View model: organization)
      