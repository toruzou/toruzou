Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "people/" + @model.get "id"
      }
      {
        name: "organization"
        label: "Organization"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "organizations/" + @model.get("organization")?["id"]
      }
      {
        name: "phone"
        label: "Phone"
        editable: false
        cell: "string"
      }
      {
        name: "email"
        label: "Email"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "mailto:#{@model.get('email')}"
      }
      {
        name: "department"
        label: "Department"
        editable: false
        cell: "string"
        formatter: fromRaw: (rawValue) -> rawValue #TODO
      }
      {
        name: "title"
        label: "Title"
        editable: false
        cell: "string"
        formatter: fromRaw: (rawValue) -> rawValue #TODO
      }
      {
        name: "owner"
        label: "Owner"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "users/" + @model.get("owner")?["id"]
      }
    ]
