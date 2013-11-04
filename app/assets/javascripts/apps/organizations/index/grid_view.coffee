Index = Toruzou.module "Organizations.Index"

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> Toruzou.linkTo("organizations/" + @model.get("id"))
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
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("users/" + rawValue["id"]) else null
    }
    {
      name: "deletedAt"
      label: "Deleted Datetime"
      editable: false
      cell: "localDatetime"
    }
  ]
