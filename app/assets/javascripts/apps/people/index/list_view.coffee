Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "people/list"
    events:
      "click #add-person-button": "addOrganization"
    regions:
      gridRegion: "#grid-container"

    constructor: (options) ->
      @organization = options?.organization
      super options

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.People.New.View()
      newView.on "people:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
