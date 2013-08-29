Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Toruzou.Common.FilteringLayout

    template: "organizations/index"
    events:
      "click #add-organization-button": "addOrganization"
    regions:
      gridRegion: "#grid-container"

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      Toruzou.dialogRegion.show new Toruzou.Organizations.New.View()
      # TODO
