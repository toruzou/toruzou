Model = Toruzou.module "Model"

required = (name, value, formValues) ->
  if (_.str.isBlank formValues["fromDate"]) and (_.str.isBlank formValues["toDate"])
    type: name
    message: "From Date or To Date is required"

Model.Career = class Career extends Backbone.Model

  urlRoot: Model.endpoint "careers"
  modelName: "career"

  defaults:
    fromDate: ""
    toDate: ""
    department: ""
    title: ""
    remarks: ""
    personId: undefined

  schema:
    fromDate:
      type: "Datepicker"
      validators: [ _.partial required, "fromDate" ]
    toDate:
      type: "Datepicker"
      validators: [ _.partial required, "toDate" ]
    department:
      type: "Text"
    title:
      type: "Text"
    remarks:
      type: "TextArea"

  attachmentsUrl: ->
    _.result(@, "url") + "/attachments"

  updateSubject: ->
    new Model.Person(@get "person")

Model.Careers = class Careers extends Backbone.PageableCollection

  url: Model.endpoint "careers"
  model: Model.Career

  state:
    sortKey: "from_date"
    order: 1


API =
  getCareers: (options) ->
    careers = new Model.Careers()
    _.extend careers.queryParams, options
    dfd = $.Deferred()
    careers.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getCareer: (id) ->
    career = new Model.Career id: id
    dfd = $.Deferred()
    career.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "careers:fetch", (options) -> API.getCareers options
Toruzou.reqres.setHandler "career:fetch", (id) -> API.getCareer id
