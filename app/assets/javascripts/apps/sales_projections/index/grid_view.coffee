Index = Toruzou.module "SalesProjections.Index"

class PeriodLinkCell extends Backgrid.Extension.LinkCell

  className: "period-cell"

  formatter:
    fromRaw: (rawValue) -> Toruzou.Model.SalesProjection.formatPeriod rawValue

  render: ->
    super
    @$el.on "click", (e) =>
      e.preventDefault()
      e.stopPropagation()
      @model.trigger "salesProjection:selected", @model
    @

class YearCell extends Backgrid.IntegerCell

  className: "year-cell"

  formatter: class Formatter
    fromRaw: (rawValue) -> rawValue


class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "year"
      label: "Fiscal Year"
      cell: YearCell
    }
    {
      name: "period"
      label: "Period"
      editable: false
      cell: PeriodLinkCell
    }
    {
      name: "amount"
      label: "Amount"
      editable: false
      cell: "integer"
    }
    {
      name: "deal"
      label: "Deal"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:deals:show", rawValue["id"] else null
    }
    {
      name: "projectType"
      label: "Project Type"
      editable: false
      cell: "string"
      formatter: fromRaw: (rawValue) -> Toruzou.Common.Formatters.option "project_types", rawValue
    }
    {
      name: "category"
      label: "Category"
      editable: false
      cell: "string"
      formatter: fromRaw: (rawValue) -> Toruzou.Common.Formatters.option "deal_categories", rawValue
    }
    {
      name: "status"
      label: "Status"
      editable: false
      cell: "string"
      formatter: fromRaw: (rawValue) -> Toruzou.Common.Formatters.option "deal_statuses", rawValue
    }
    {
      name: "organization"
      label: "Client Organization"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:organizations:show", rawValue["id"] else null
    }
    {
      name: "remarks"
      label: "Remarks"
      editable: false
      cell: "string"
    }
    {
      name: "delete"
      label: ""
      editable: false
      sortable: false
      cell: class extends Backgrid.Extension.IconButtonCell
        render: ->
          @$el.empty()
          $deleteButton = @renderIconButton "trash", "Delete sales projection"
          $deleteButton.addClass "alert"
          $deleteButton.on "click", (e) =>
            e.preventDefault()
            e.stopPropagation()
            @model.destroy().done -> Toruzou.SalesProjections.trigger "salesProjection:deleted" 
          @$el.append $deleteButton
          @
    }
  ]

  initialize: (options) ->
    super options
    @handler = _.bind @refresh, @
    Toruzou.SalesProjections.on "salesProjection:saved salesProjection:deleted", @handler
    @listenTo @collection, "salesProjection:selected", (model) => @showSalesProjection model

  showSalesProjection: (salesProjection) ->
    return unless salesProjection
    $.when(Toruzou.request "salesProjection:fetch", salesProjection.get "id").done (salesProjection) =>
      if salesProjection
        view = new Toruzou.SalesProjections.Edit.View model: salesProjection
        # view.on "item:closed", => @refresh()
        Toruzou.dialogRegion.show view

  refresh: ->
    @collection.fetch()

  close: ->
    return if @isClosed
    super
    Toruzou.SalesProjections.off "salesProjection:saved salesProjection:deleted", @handler
