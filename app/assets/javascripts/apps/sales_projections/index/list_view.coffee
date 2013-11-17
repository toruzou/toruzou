Index = Toruzou.module "SalesProjections.Index"

class Index.ListView extends Marionette.Layout

  template: "sales_projections/list"
  events:
    "click #add-sales-projection-button": "addSalesProjection"
  regions:
    gridRegion: "#grid-container"

  constructor: (options) ->
    super options
    @deal = options.deal

  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection

  addSalesProjection: (e) ->
    e.preventDefault()
    e.stopPropagation()
    salesProjection = Toruzou.request "salesProjection:new", dealId: @deal.get("id")
    newView = new Toruzou.SalesProjections.New.View model: salesProjection
    newView.on "salesProjection:saved", => @refresh()
    Toruzou.dialogRegion.show newView

  refresh: ->
    @collection.fetch()
