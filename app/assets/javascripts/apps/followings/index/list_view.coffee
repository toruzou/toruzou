Index = Toruzou.module "Followings.Index"

class Index.ListView extends Marionette.Layout

  template: "followings/list"
  regions:
    gridRegion: "#grid-container"

  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection
