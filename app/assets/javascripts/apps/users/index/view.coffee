Index = Toruzou.module "Users.Index"

class Index.View extends Marionette.Layout

  template: "users/index"
  regions:
    listRegion: ".list-container"
    filterRegion: ".filter-container"

  onShow: ->
    listView = new Index.ListView collection: @collection
    filterView = new Index.FilterView collection: @collection
    filterView.on "users:filterChanged", => listView.refresh()
    @listRegion.show listView
    @filterRegion.show filterView
