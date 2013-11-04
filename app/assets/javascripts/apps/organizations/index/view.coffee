Index = Toruzou.module "Organizations.Index"

class Index.View extends Marionette.Layout

  template: "organizations/index"
  regions:
    listRegion: ".list-container"
    filterRegion: ".filter-container"

  onShow: ->
    listView = new Index.ListView collection: @collection
    filterView = new Index.FilterView collection: @collection
    filterView.on "organizations:filterChanged", => listView.refresh()
    @listRegion.show listView
    @filterRegion.show filterView
