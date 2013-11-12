Panel = Toruzou.module "Activities.Panel"

class Panel.ActivityView extends Marionette.ItemView

  template: "activities/panel/activity"
  events:
    "click .status" : "toggleDone"

  constructor: (options) ->
    super options
    @title = _.result options, "title"

  serializeData: ->
    data = super
    data["title"] = @title if @title
    data

  toggleDone: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.when(Toruzou.request "activity:fetch", @model.get "id").then (activity) =>
      activity.save("done": activity.toggleDone()).done (activity) =>
        Toruzou.Activities.trigger "activity:saved", activity
        @refresh activity

  refresh: (model) ->
    @model = model
    @render()


class Panel.View extends Marionette.Layout

  template: "activities/panel/index"
  regions:
    lastActivityRegion: ".last-activity"
    nextActivityRegion: ".next-activity"

  onShow: ->
    lastActivity = Toruzou.request "activity:new", @model?.get("lastActivity")
    @lastActivityRegion.show new Panel.ActivityView
      title: "Last Activity"
      model: lastActivity
    nextActivity = Toruzou.request "activity:new", @model?.get("nextActivity")
    @nextActivityRegion.show new Panel.ActivityView
      title: "Next Activity"
      model: nextActivity


