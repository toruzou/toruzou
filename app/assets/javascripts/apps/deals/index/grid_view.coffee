Toruzou.module "Deals.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: class extends Backgrid.Extension.LinkCell
          href: -> "deals/" + @model.get "id"
      }
      {
        name: "organization"
        label: "Organization"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("organizations/" + rawValue["id"]) else null
      }
      {
        name: "contact"
        label: "Contact Person"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("people/" + rawValue["id"]) else null
      }
      {
        name: "pm"
        label: "Project Manager"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("users/" + rawValue["id"]) else null
      }
      {
        name: "sales"
        label: "Sales Person"
        editable: false
        formatter: fromRaw: (rawValue) -> if rawValue then rawValue["name"] else ""
        cell: class extends Backgrid.Extension.LinkCell
          href: (rawValue) -> if rawValue?["id"] then Toruzou.linkTo("users/" + rawValue["id"]) else null
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
    ]
