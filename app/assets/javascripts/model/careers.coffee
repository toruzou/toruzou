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

Model.Careers = class Careers extends Backbone.PageableCollection

  url: Model.endpoint "careers"
  model: Model.Career

  state:
    sortKey: "from_date"
    order: 1


API =
  createCareer: (options) ->
    new Model.Career options
  createCareers: (options) ->
    collection = new Model.Careers()
    _.extend collection.queryParams, options
    collection
  getCareer: (id) ->
    model = API.createCareer id: id
    model.fetch()
  getCareers: (options) ->
    collection = API.createCareers options
    collection.fetch()

Toruzou.reqres.setHandler "career:new", API.createCareer
Toruzou.reqres.setHandler "careers:new", API.createCareers
Toruzou.reqres.setHandler "career:fetch", API.getCareer
Toruzou.reqres.setHandler "careers:fetch", API.getCareers