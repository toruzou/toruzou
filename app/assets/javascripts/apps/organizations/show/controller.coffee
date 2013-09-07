Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  Show.Controller =
    
    showOrganization: (id, slug) ->
      $.when(Toruzou.request "organization:fetch", id).done (organization) ->
        layout = Toruzou.Common.ApplicationLayout.show()
        view = new Show.View model: organization
        layout.mainRegion.show view
        view.show slug or "updates"
