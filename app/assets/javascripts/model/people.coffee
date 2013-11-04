Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Person = class Person extends Backbone.Model

  urlRoot: Model.endpoint "people"
  modelName: "person"

  defaults:
    name: ""
    phone: ""
    email: ""
    address: ""
    remarks: ""
    organization: null
    organizationId: null
    owner: null
    ownerId: null
    careers: []

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
    phone:
      type: "Text"
      validators: [ /\d{2,4}-?\d{2,4}-?\d{4}/ ]
    email:
      type: "Text"
      validators: [ "email" ]
    address:
      type: "Text"
    remarks:
      type: "TextArea"
    ownerId: $.extend true, {},
      Model.Schema.User,
      title: "Owner"
      key: "owner"
    owner:
      formatter: (value) -> value?.name
    deletedAt:
      title: "Deleted Datetime"
      formatter: (value) -> Toruzou.Common.Formatters.localDatetime value

  createNote: ->
    note = new Model.Note()
    note.subject = @
    note
    
  attachmentsUrl: ->
    _.result(@, "url") + "/attachments"

Model.People = class People extends Backbone.PageableCollection

  url: Model.endpoint "people"
  model: Model.Person

  state:
    sortKey: "name"
    order: 1
    

API =
  getPeople: (options) ->
    people = new Model.People()
    _.extend people.queryParams, options
    dfd = $.Deferred()
    people.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getPerson: (id) ->
    person = new Model.Person id: id
    dfd = $.Deferred()
    person.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "people:fetch", (options) -> API.getPeople options
Toruzou.reqres.setHandler "person:fetch", (id) -> API.getPerson id