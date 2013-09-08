Toruzou.module "Activities.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class ActionCell extends Backgrid.Cell

    className: "activity-action-cell"

    render: ->
      @$el.empty()
      rawValue = @model.get @column.get("name")
      @$el.append Toruzou.Models.Activity::renderAction rawValue if rawValue
      @delegateEvents()

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "done"
        label: "Done"
        cell: "select-row"
      }
      {
        name: "action"
        label: "Action"
        editable: false
        cell: ActionCell
      }
      {
        name: "subject"
        label: "Subject"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          render: ->
            super
            @$el.on "click", (e) =>
              e.preventDefault()
              e.stopPropagation()
              @model.trigger "activity:selected", @model
            @
      }
      # TODO organizations, deals, people, users
      {
        name: "date"
        label: "Date"
        editable: false
        cell: "localDate"
      }
    ]

    initialize: (options) ->
      super options
      @listenTo @collection, "activity:selected", (model) => @showActivity model
      @listenTo @collection, "backgrid:selected", (model, checked) => @toggleDone model, checked

    showActivity: (activity) ->
      return unless activity
      $.when(Toruzou.request "activity:fetch", activity.get "id").done (activity) ->
        Toruzou.dialogRegion.show new Toruzou.Activities.Edit.View model: activity if activity

    toggleDone: (activity, done) ->
      activity.set "done", done
      activity.save success: (activity) => @trigger "activity:toggleDone", activity, done
