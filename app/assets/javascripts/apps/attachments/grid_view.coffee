Attachments = Toruzou.module "Attachments"

class Attachments.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> Toruzou.Model.endpoint("attachments/" + @model.get("id"))
        renderLink: -> super.attr("data-bypass", "")
    }
    {
      name: "comments"
      label: "Comments"
      cell: "string"
    }
    {
      name: "updatedAt"
      label: "Updated Datetime"
      editable: false
      cell: "localDatetime"
    }
    {
      name: "delete"
      label: ""
      editable: false
      sortable: false
      cell: class extends Backgrid.Extension.IconButtonCell
        iconName: "trash"
        title: "Delete file"
        renderIconButton: (iconName, title) ->
          $button = super iconName, title
          $button.addClass("alert").on "click", (e) =>
            e.preventDefault()
            e.stopPropagation()
            @model.destroy success: @refresh
          $button
    }
  ]

  constructor: (options) ->
    super options
    # FIXME workaround for restoring previous value, but this is ugly.
    @collection.on "backgrid:edit", (model, column) ->
      name = column.get "name"
      model.set "#{name}:previous", model.get name
    @collection.on "backgrid:edited", (model, column) ->
      name = column.get "name"
      value = model.get name
      model.save name, value, error: -> 
        previousValue = model.get "#{name}:previous"
        unless _.isUndefined previousValue
          model.set name, previousValue

  refresh: ->
    @collection.fetch()
    