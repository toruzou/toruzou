Index = Toruzou.module "Careers.Index"

class DateLinkCell extends Backgrid.Extension.LinkCell

  render: ->
    super
    @$el.on "click", (e) =>
      e.preventDefault()
      e.stopPropagation()
      @model.trigger "career:selected", @model
    @

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "fromDate"
      label: "From"
      editable: false
      formatter: new Backgrid.Extension.LocalDateCell::formatter()
      cell: DateLinkCell
    }
    {
      name: "toDate"
      label: "To"
      editable: false
      formatter: new Backgrid.Extension.LocalDateCell::formatter()
      cell: DateLinkCell
    }
    {
      name: "department"
      label: "Department"
      editable: false
      cell: "string"
    }
    {
      name: "title"
      label: "Title"
      editable: false
      cell: "string"
    }
    {
      name: "remarks"
      label: "Remarks"
      editable: false
      cell: "string"
    }
  ]

  initialize: (options) ->
    super options
    @listenTo @collection, "career:selected", (model) => @showCareer model

  showCareer: (career) ->
    return unless career
    $.when(Toruzou.request "career:fetch", career.get "id").done (career) =>
      if career
        view = new Toruzou.Careers.Edit.View model: career
        view.on "item:closed", => @refresh()
        Toruzou.dialogRegion.show view

  refresh: ->
    @collection.fetch()
