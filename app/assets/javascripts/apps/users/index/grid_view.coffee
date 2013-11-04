Index = Toruzou.module "Users.Index"

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> Toruzou.request "route:users:show", @model.get("id")
    }
    {
      name: "email"
      label: "Email"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: -> "mailto:#{@model.get('email')}"
    }
    {
      name: "lastSignInAt"
      label: "Last Sign-in Datetime"
      editable: false
      cell: "localDatetime"
    }
    {
      name: "lastSignInIp"
      label: "Last Sign-in IP Address"
      editable: false
      cell: "string"
    }
  ]
