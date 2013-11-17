Index = Toruzou.module "SalesProjections.Index"

class Index.View extends Marionette.Layout

  template: "sales_projections/index"
  regions:
    listRegion: ".list-container"
    filterRegion: ".filter-container"

  onShow: ->
    listView = new Index.ListView collection: @collection
    filterView = new Index.FilterView collection: @collection
    filterView.on "salesProjections:filterChanged", => listView.refresh()
    @listRegion.show listView
    @filterRegion.show filterView
