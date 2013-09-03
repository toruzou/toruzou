Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Marionette.Layout

    template: "organizations/index"
    events:
      "click #add-organization-button": "addOrganization"
    regions:
      filterRegion: ".filter-container"
      gridRegion: "#grid-container"

    onShow: ->
      filterView = new Index.FilterView collection: @collection
      filterView.on "organizations:filterChanged", => @refresh()
      @filterRegion.show filterView
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.Organizations.New.View()
      newView.on "organizations:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
