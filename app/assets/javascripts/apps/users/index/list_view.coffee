Index = Toruzou.module "Users.Index"

class Index.ListView extends Marionette.Layout

  template: "users/list"
  regions:
    gridRegion: "#grid-container"

  constructor: (options) ->
    super options
    @organization = options?.organization

  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection

  refresh: ->
    @collection.fetch()
