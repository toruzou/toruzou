Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "organizations/" + @model.get "id"
      }
      {
        name: "abbreviation"
        label: "Abbreviation"
        editable: false
        cell: "string"
      }
      {
        name: "url"
        label: "Website"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: -> @model.get "url"
      }
      {
        name: "owner"
        label: "Owner"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["username"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "users/" + @model.get("owner")?["id"]
      }
    ]
