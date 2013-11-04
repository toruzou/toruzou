Index = Toruzou.module "Activities.Index"

class Index.View extends Marionette.Layout

  template: "activities/index"
  regions:
    listRegion: ".list-container"
    filterRegion: ".filter-container"

  onShow: ->
    listView = new Index.ListView collection: @collection
    filterView = new Index.FilterView collection: @collection
    filterView.on "activities:filterChanged", => listView.refresh()
    @listRegion.show listView
    @filterRegion.show filterView
