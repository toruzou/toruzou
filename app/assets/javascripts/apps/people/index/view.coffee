Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Marionette.Layout

    template: "people/index"
    regions:
      listRegion: ".list-container"
      filterRegion: ".filter-container"

    onShow: ->
      listView = new Index.ListView collection: @collection
      filterView = new Index.FilterView collection: @collection
      filterView.on "people:filterChanged", => listView.refresh()
      @listRegion.show listView
      @filterRegion.show filterView
