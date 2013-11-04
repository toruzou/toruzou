Index = Toruzou.module "Deals.Index"

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: class extends Backgrid.Extension.LinkCell
        href: -> Toruzou.request "route:deals:show", @model.get "id"
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
      name: "contact"
      label: "Contact Person"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:people:show", rawValue["id"] else null
    }
    {
      name: "pm"
      label: "Project Manager"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:users:show", rawValue["id"] else null
    }
    {
      name: "sales"
      label: "Sales Person"
      editable: false
      formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
      cell: class extends Backgrid.Extension.LinkCell
        href: (rawValue) -> if rawValue?["id"] then Toruzou.request "route:users:show", rawValue["id"] else null
    }
    {
      name: "status"
      label: "Status"
      editable: false
      cell: "string"
    }
    {
      name: "amount"
      label: "Amount"
      editable: false
      cell: "integer"
    }
    {
      name: "accuracy"
      label: "Accuracy"
      editable: false
      cell: "integer"
      formatter: class extends Backgrid.NumberFormatter
        fromRaw: (rawValue) ->
          formattedValue = super
          if _.str.isBlank formattedValue then "" else "#{formattedValue} %"
    }
    {
      name: "startDate"
      label: "Start Date"
      editable: false
      cell: "localDate"
    }
    {
      name: "orderDate"
      label: "Order Date"
      editable: false
      cell: "localDate"
    }
    {
      name: "acceptDate"
      label: "Accept Date"
      editable: false
      cell: "localDate"
    }
    {
      name: "deletedAt"
      label: "Deleted Datetime"
      editable: false
      cell: "localDatetime"
    }
  ]
