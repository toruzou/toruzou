Toruzou.module "Activities.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "activities/list"
    events:
      "click #add-activity-button": "addActivity"
    regions:
      gridRegion: "#grid-container"

    constructor: (options) ->
      super options
      @organization = options?.organization
      @deal = options?.deal
      @people = options?.people
      
    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addActivity: (e) ->
      e.preventDefault()
      e.stopPropagation()
      activity = new Toruzou.Models.Activity()
      activity.set "organization", @organization if @organization
      activity.set "deal", @deal if @deal
      activity.set "people", @people if @people
      newView = new Toruzou.Activities.New.View model: activity
      newView.on "activities:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
