Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

class Model.Person extends Backbone.Model

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

class Model.People extends Backbone.PageableCollection

  url: Model.endpoint "people"
  model: Model.Person

  state:
    sortKey: "name"
    order: 1
    

API =
  createPerson: (options) ->
    new Model.Person options
  createPeople: (options) ->
    collection = new Model.People()
    _.extend collection.queryParams, options
    collection
  getPerson: (id) ->
    model = API.createPerson id: id
    model.fetch()
  getPeople: (options) ->
    collection = API.createPeople options
    collection.fetch()
  follow: (id) ->
    model = API.createPerson id: id
    model.save url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createPerson id: id
    model.destroy url: "#{_.result model, "url"}/following"

Toruzou.reqres.setHandler "person:new", API.createPerson
Toruzou.reqres.setHandler "people:new", API.createPeople
Toruzou.reqres.setHandler "person:fetch", API.getPerson
Toruzou.reqres.setHandler "people:fetch", API.getPeople
Toruzou.reqres.setHandler "person:follow", API.follow
Toruzou.reqres.setHandler "person:unfollow", API.unfollow
