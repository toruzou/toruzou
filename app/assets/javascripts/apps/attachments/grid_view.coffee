Toruzou.module "Attachments", (Attachments, Toruzou, Backbone, Marionette, $, _) ->

  class Attachments.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> Toruzou.Models.endpoint("attachments/" + @model.get("id"))
          renderLink: -> super.attr("data-bypass", "")
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

    refresh: ->
      @collection.fetch()
      