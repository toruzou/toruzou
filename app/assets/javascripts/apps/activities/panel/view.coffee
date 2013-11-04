Panel = Toruzou.module "Activities.Panel"

class Panel.ActivityView extends Marionette.ItemView

  template: "activities/panel/activity"
  events:
    "click .subject > .link": "showActivity"
    "click .status" : "toggleDone"

  constructor: (options) ->
    super options
    @title = _.result options, "title"

  serializeData: ->
    data = super
    data["title"] = @title if @title
    data

  showActivity: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.when(Toruzou.request "activity:fetch", @model.get "id").done (activity) =>
      if activity
        Toruzou.dialogRegion.show new Toruzou.Activities.Edit.View model: activity

  toggleDone: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.when(Toruzou.request "activity:fetch", @model.get "id").done (activity) =>
      if activity
        activity.save "done", activity.toggleDone(), success: (model) =>
          Toruzou.Activities.trigger "activity:saved", model
          @refresh model

  refresh: (model) ->
    @model = model
    @render()


class Panel.View extends Marionette.Layout

  template: "activities/panel/index"
  regions:
    lastActivityRegion: ".last-activity"
    nextActivityRegion: ".next-activity"

  onShow: ->
    @lastActivityRegion.show new Panel.ActivityView
      title: "Last Activity"
      model: new Toruzou.Models.Activity @model?.get("lastActivity")
    @nextActivityRegion.show new Panel.ActivityView
      title: "Next Activity"
      model: new Toruzou.Models.Activity @model?.get("nextActivity")


