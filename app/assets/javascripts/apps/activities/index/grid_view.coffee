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
      {
        name: "date"
        label: "Date"
        editable: false
        cell: "localDate"
      }
      {
        name: "deal"
        label: "Deal"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("deals/" + rawValue["id"]) else null
      }
      {
        name: "organization"
        label: "Organization"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("organizations/" + rawValue["id"]) else null
      }
      {
        name: "users"
        label: "Users"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("users/" + rawValue["id"]) else null
      }
      {
        name: "people"
        label: "Contacts"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("people/" + rawValue["id"]) else null
      }
      {
        name: "delete"
        label: ""
        editable: false
        sortable: false
        cell: class extends Backgrid.Extension.IconButtonCell
          title: "Delete"
          iconClassName: "remove"
          createIconLink: ->
            $link = super.addClass "alert"
            $link.on "click", (e) =>
              e.preventDefault()
              e.stopPropagation()
              @model.destroy success: @refresh
            $link
      }
    ]

    initialize: (options) ->
      super options
      @listenTo @collection, "activity:selected", (model) => @showActivity model
      @listenTo @collection, "backgrid:selected", (model, checked) => @toggleDone model, checked

    showActivity: (activity) ->
      return unless activity
      $.when(Toruzou.request "activity:fetch", activity.get "id").done (activity) =>
        if activity
          view = new Toruzou.Activities.Edit.View model: activity
          view.on "item:closed", => @refresh()
          Toruzou.dialogRegion.show view

    toggleDone: (activity, done) ->
      activity.set "done", done
      activity.save success: (activity) => @trigger "activity:toggleDone", activity, done

    refresh: ->
      @collection.fetch()
