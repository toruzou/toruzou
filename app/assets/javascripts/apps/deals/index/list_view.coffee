Toruzou.module "Deals.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "deals/list"
    events:
      "click #add-deal-button": "addDeal"
    regions:
      gridRegion: "#grid-container"

    constructor: (options) ->
      super options
      @organization = options?.organization
      @person = options?.person

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addDeal: (e) ->
      e.preventDefault()
      e.stopPropagation()
      deal = new Toruzou.Models.Deal()
      deal.set "organization", @organization if @organization
      deal.set "contact", @person if @person
      newView = new Toruzou.Deals.New.View model: deal
      newView.on "deals:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
