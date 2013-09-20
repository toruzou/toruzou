Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "organizations/list"
    events:
      "click #add-organization-button": "addOrganization"
    regions:
      gridRegion: "#grid-container"

    constructor: (options) ->
      super options
      @owner = options?.owner

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      organization = new Toruzou.Models.Organization()
      organization.set "owner", @owner if @owner
      newView = new Toruzou.Organizations.New.View model: organization
      newView.on "organizations:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
