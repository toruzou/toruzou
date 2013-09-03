Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Marionette.Layout

    template: "people/index"
    events:
      "click #add-person-button": "addOrganization"
    regions:
      filterRegion: ".filter-container"
      gridRegion: "#grid-container"

    onShow: ->
      filterView = new Index.FilterView collection: @collection
      filterView.on "people:filterChanged", => @refresh()
      @filterRegion.show filterView
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.People.New.View()
      newView.on "people:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
