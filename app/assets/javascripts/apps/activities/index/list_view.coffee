Index = Toruzou.module "Activities.Index"

class Index.ListView extends Marionette.Layout

  template: "activities/list"
  events:
    "click #add-activity-button": "addActivity"
  regions:
    gridRegion: "#grid-container"

  constructor: (options) ->
    super options
    @handler = _.bind @refresh, @
    @organization = options?.organization
    @deal = options?.deal
    @users = options?.users
    @people = options?.people
    
  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection

  addActivity: (e) ->
    e.preventDefault()
    e.stopPropagation()
    activity = new Toruzou.Model.Activity()
    activity.set "organization", @organization if @organization
    activity.set "deal", @deal if @deal
    activity.set "users", @users if @users
    activity.set "people", @people if @people
    Toruzou.Activities.on "activity:saved activity:deleted activity:restored", @handler
    Toruzou.dialogRegion.show new Toruzou.Activities.New.View model: activity

  refresh: ->
    @collection.fetch()

  close: ->
    return if @isClosed
    super
    Toruzou.off "activity:saved activity:deleted", @handler
