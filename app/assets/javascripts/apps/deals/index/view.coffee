Toruzou.module "Deals.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Marionette.Layout

    template: "deals/index"
    regions:
      listRegion: ".list-container"
      filterRegion: ".filter-container"

    onShow: ->
      listView = new Index.ListView collection: @collection
      filterView = new Index.FilterView collection: @collection
      filterView.on "deals:filterChanged", => listView.refresh()
      @listRegion.show listView
      @filterRegion.show filterView
