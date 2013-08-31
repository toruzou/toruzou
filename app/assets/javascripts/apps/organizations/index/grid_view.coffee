Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "organizations/" + @model.get "id"
      }
      {
        name: "abbreviation"
        label: "Abbreviation"
        editable: false
        cell: "string"
      }
      {
        name: "owner"
        label: "Owner"
        editable: false
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> "users/" + @model.get("owner")?["id"]
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["username"] else ""
      }
      {
        name: "url"
        label: "Website"
        editable: false
        cell: Toruzou.Common.GridView.LinkCell.extend href: -> @model.get "url"
      }
    ]
