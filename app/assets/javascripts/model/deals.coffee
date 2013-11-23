Model = Toruzou.module "Model"

class Model.Deal extends Backbone.Model

  urlRoot: Model.endpoint "deals"
  modelName: "deal"
  projectTypes: _.map Toruzou.Configuration.settings.options.project_types, (value, key) -> { val: key, label: value }
  categories: _.map Toruzou.Configuration.settings.options.deal_categories, (value, key) -> { val: key, label: value }
  statuses: _.map Toruzou.Configuration.settings.options.deal_statuses, (value, key) -> { val: key, label: value }
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
    projectType: ""
    category: ""
    organization: null
    organizationId: null
    pm: null
    pmId: null
    sales: null
    salesId: null
    contact: null
    contactId: null
    status: ""
    accuracy: null
    startDate: ""
    orderDate: ""
    acceptDate: ""
    
  schema:
    name:
      type: "Text"
      validators: [ "required" ]
    projectType:
      type: "Selectize"
      restore: (model) ->
        type = model.get "projectType"
        {
          value: type
          data: type
        }
      options: @::projectTypes
      formatter: (value) -> Toruzou.Common.Formatters.option "project_types", value
    category:
      type: "Selectize"
      restore: (model) ->
        category = model.get "category"
        {
          value: category
          data: category
        }
      options: @::categories
      formatter: (value) -> Toruzou.Common.Formatters.option "deal_categories", value
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
      formatter: (value) -> Toruzou.Common.Formatters.option "deal_statuses", value
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
    model.save null, url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createDeal id: id
    model.destroy url: "#{_.result model, "url"}/following"

Toruzou.reqres.setHandler "deal:new", API.createDeal
Toruzou.reqres.setHandler "deals:new", API.createDeals
Toruzou.reqres.setHandler "deal:fetch", API.getDeal
Toruzou.reqres.setHandler "deals:fetch", API.getDeals
Toruzou.reqres.setHandler "deal:follow", API.follow
Toruzou.reqres.setHandler "deal:unfollow", API.unfollow
