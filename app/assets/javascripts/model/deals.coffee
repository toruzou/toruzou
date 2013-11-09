Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

class Model.Deal extends Backbone.Model

  urlRoot: Model.endpoint "deals"
  modelName: "deal"
  statuses: [
    "Plan"
    "Proposal"
    "In Negotiation"
    "Won"
    "Lost"
  ]
  accuracies: _.map [
    "0"
    "25"
    "50"
    "75"
    "90"
    "100"
  ], (accuracy) -> { val: accuracy, label: Toruzou.Common.Formatters.percent accuracy }

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
      title: "Project Manager"
      formatter: (value) -> value?.name
    salesId: $.extend true, {},
      Model.Schema.User,
      title: "Sales Person"
      key: "sales"
    sales:
      title: "Sales Person"
      formatter: (value) -> value?.name
    contactId: $.extend true, {},
      Model.Schema.Person,
      title: "Contact Person"
      key: "contact"
    contact:
      title: "Contact Person"
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
      type: "Selectize"
      restore: (model) ->
        accuracy = model.get "accuracy"
        {
          value: accuracy
          data: { val: accuracy, label: Toruzou.Common.Formatters.percent accuracy }
        }
      options: @::accuracies
      formatter: (value) -> Toruzou.Common.Formatters.percent value
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
    

class Model.Deals extends Backbone.PageableCollection

  url: Model.endpoint "deals"
  model: Model.Deal

  state:
    sortKey: "name"
    order: 1


API =
  createDeal: (options) ->
    new Model.Deal options
  createDeals: (options) ->
    collection = new Model.Deals()
    _.extend collection.queryParams, options
    collection
  getDeal: (id) ->
    model = API.createDeal id: id
    model.fetch()
  getDeals: (options) ->
    collection = API.createDeals options
    collection.fetch()
  follow: (id) ->
    model = API.createDeal id: id
    model.save url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createDeal id: id
    model.destroy url: "#{_.result model, "url"}/following"

Toruzou.reqres.setHandler "deal:new", API.createDeal
Toruzou.reqres.setHandler "deals:new", API.createDeals
Toruzou.reqres.setHandler "deal:fetch", API.getDeal
Toruzou.reqres.setHandler "deals:fetch", API.getDeals
Toruzou.reqres.setHandler "deal:follow", API.follow
Toruzou.reqres.setHandler "deal:unfollow", API.unfollow
