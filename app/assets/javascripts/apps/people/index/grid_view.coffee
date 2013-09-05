Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "people/" + @model.get "id"
      }
      {
        name: "organization"
        label: "Organization"
        editable: false
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "organizations/" + @model.get("organization")?["id"]
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
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
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "mailto:#{@model.get('email')}"
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
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "users/" + @model.get("owner")?["id"]
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["username"] else ""
      }
    ]
