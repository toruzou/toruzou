Index = Toruzou.module "People.Index"

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> Toruzou.request "route:people:show", @model.get("id")
    }
    {
      name: "organization"
      label: "Organization"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:organizations:show", rawValue["id"] else null
    }
    {
      name: "career"
      label: "Department"
      editable: false
      cell: "string"
      formatter: fromRaw: (rawValue) -> rawValue?["department"]
    }
    {
      name: "career"
      label: "Title"
      editable: false
      cell: "string"
      formatter: fromRaw: (rawValue) -> rawValue?["title"]
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
      name: "owner"
      label: "Owner"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:users:show", rawValue["id"] else null
    }
    {
      name: "updatedAt"
      label: "Updated Datetime"
      editable: false
      cell: "localDatetime"
    }
    {
      name: "deletedAt"
      label: "Deleted Datetime"
      editable: false
      cell: "localDatetime"
    }
  ]
