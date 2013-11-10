Index = Toruzou.module "Deals.Index"

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
    deal = Toruzou.request "deal:new"
    deal.set "organization", @organization if @organization
    deal.set "contact", @person if @person
    Toruzou.execute "show:deals:create", deal

  refresh: ->
    @collection.fetch()
