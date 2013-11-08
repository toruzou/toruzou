Index = Toruzou.module "Timeline.Index"

class Index.View extends Marionette.Layout

  template: "timeline/index"
  regions:
    notificationsRegion: "#notifications-container"

  onShow: ->
    @notificationsRegion.show new Toruzou.Updates.Index.CollectionView collection: @collection
