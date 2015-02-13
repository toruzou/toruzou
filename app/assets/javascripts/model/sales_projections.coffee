Model = Toruzou.module "Model"

START_MONTH_OF_FISCAL_YEAR = 4
getFiscalYearOf = (moment) -> if moment.month() < START_MONTH_OF_FISCAL_YEAR then moment.year() - 1 : moment.year()

class Model.SalesProjection extends Backbone.Model

  urlRoot: -> Model.endpoint "sales"
  modelName: "sales_projection"

  statuses: _.map Toruzou.Configuration.settings.options.deal_statuses, (value, key) -> { val: key, label: value }
  accuracies: _.map [
    "0"
    "25"
    "50"
    "75"
    "90"
    "100"
  ], (accuracy) -> { val: accuracy, label: Toruzou.Common.Formatters.percent accuracy }

  periods: [
    { val: 1, label: "1st half" }
    { val: 2, label: "2nd half" }
  ]

  @formatPeriod: (value) ->
    period = _.find @::periods, (period) -> period.val is value
    if period then period.label else ""

  defaults:
    dealId: undefined
    deal: undefined
    year: undefined
    period: undefined
    amount: undefined
    status: ""
    accuracy: null
    startDate: ""
    endDate: ""
    orderDate: ""
    profitAmount: undefined
    profitRate: undefined
    obicNo: undefined
    remarks: ""

  schema:
    dealId: $.extend true, {},
      Model.Schema.Deal,
      title: "Deal"
      key: "deal"
      validators: [ "required" ]
    deal:
      formatter: (value) -> value?.name
    year:
      type: "PositiveInteger"
      validators: [ "required" ]
    period:
      type: "Selectize"
      validators: [ "required" ]
      restore: (model) ->
        period = model.get "period"
        {
          value: period
          data: { val: period, label: Model.SalesProjection.formatPeriod(period) }
        }
      options: @::periods
      formatter: (value) => Model.SalesProjection.formatPeriod value
    amount:
      type: "PositiveAmount"
      formatter: (value) -> Toruzou.Common.Formatters.amount value
      validators: [ "required" ]
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
      validators: [ "required" ]
    endDate:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
      validators: [ "required" ]
    orderDate:
      type: "Datepicker"
      formatter: (value) -> Toruzou.Common.Formatters.localDate value
    profitAmount:
      type: "PositiveAmount"
      formatter: (value) -> Toruzou.Common.Formatters.amount value
    profitRate:
      type: "PositivePercentFloat"
      formatter: (value) -> Toruzou.Common.Formatters.percent value
    obicNo:
      type: "TextArea"
      formatter: (value) -> Toruzou.Common.Formatters.truncateText value
    remarks:
      type: "TextArea"
      formatter: (value) -> Toruzou.Common.Formatters.truncateText value

  parse: (resp, options) ->
    attributes = super resp, options
    attributes.organization = attributes.deal?.organization
    attributes.projectType = attributes.deal?.project_type
    attributes.category = attributes.deal?.category
    attributes


class Model.SalesProjections extends Backbone.PageableCollection

  url: -> Model.endpoint "sales"
  model: Model.SalesProjection

  state:
    sortKey: "year"
    order: -1


API =
  createSalesProjection: (options) ->
    new Model.SalesProjection options
  createSalesProjections: (options) ->
    collection = new Model.SalesProjections()
    _.extend collection.queryParams, options
    collection
  getSalesProjection: (id) ->
    model = API.createSalesProjection id: id
    model.fetch()
  getSalesProjections: (options) ->
    collection = API.createSalesProjections options
    collection.fetch()

Toruzou.reqres.setHandler "salesProjection:new", API.createSalesProjection
Toruzou.reqres.setHandler "salesProjections:new", API.createSalesProjections
Toruzou.reqres.setHandler "salesProjection:fetch", API.getSalesProjection
Toruzou.reqres.setHandler "salesProjections:fetch", API.getSalesProjections
