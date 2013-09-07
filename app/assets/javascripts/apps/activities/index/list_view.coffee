Toruzou.module "Activities.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "activities/list"
    events:
      "click #add-activity-button": "addActivity"
    regions:
      gridRegion: "#grid-container"

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addActivity: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.Activities.New.View
      newView.on "activities:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
