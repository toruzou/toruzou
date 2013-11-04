Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Deal = class Deal extends Backbone.Model

  urlRoot: Model.endpoint "deals"
  modelName: "deal"
  statuses: [
    "Plan"
    "Proposal"
    "In Negotiation"
    "Won"
    "Lost"
  ]

  defaults:
    name: ""
    organization: null
    organizationId: null
    pm: null
    pmId: null
    sales: null
    salesId: null
    contact: null
    contactId: null
    status: ""
    amount: null
    accuracy: null
    startDate: ""
    orderDate: ""
    acceptDate: ""
    
  schema:
    name:
      type: "Text"
      validators: [ "required" ]
    organizationId: $.extend true, {},
      Model.Schema.Organization,
      title: "Organization"
      key: "organization"
    organization:
      formatter: (value) -> value?.name
    pmId: $.extend true, {},
      Model.Schema.User,
      title: "Project Manager"
      key: "pm"
    pm:
      formatter: (value) -> value?.name
    salesId: $.extend true, {},
      Model.Schema.User,
      title: "Sales Person"
      key: "sales"
    sales:
      formatter: (value) -> value?.name
    contactId: $.extend true, {},
      Model.Schema.Person,
      title: "Contact Person"
      key: "contact"
    contact:
      formatter: (value) -> value?.name
    status:
      type: "Selectize"
      restore: (model) ->
        status = model.get "status"
        {
          value: status
          data: status
        }
      options: @::statuses
    amount:
      type: "PositiveAmount"
      formatter: (value) -> Toruzou.Common.Formatters.amount value
    accuracy:
      type: "PositivePercentInteger"
      formatter: (value) -> Toruzou.Common.Formatters.percent value
      validators: [
        (value, formValues) ->
          return { message: "Invalid accuracy" } if value and value > 100
      ]
    startDate:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
    orderDate:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
    acceptDate:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
    deletedAt:
      title: "Deleted Datetime"
      formatter: (value) -> Toruzou.Common.Formatters.localDatetime value

  createNote: ->
    note = new Model.Note()
    note.subject = @
    note
    
  attachmentsUrl: ->
    _.result(@, "url") + "/attachments"
    

Model.Deals = class Deal extends Backbone.PageableCollection

  url: Model.endpoint "deals"
  model: Model.Deal

  state:
    sortKey: "name"
    order: 1


API =
  getDeals: (options) ->
    deals = new Model.Deals()
    _.extend deals.queryParams, options
    dfd = $.Deferred()
    deals.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getDeal: (id) ->
    deal = new Model.Deal id: id
    dfd = $.Deferred()
    deal.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "deals:fetch", (options) -> API.getDeals options
Toruzou.reqres.setHandler "deal:fetch", (id) -> API.getDeal id