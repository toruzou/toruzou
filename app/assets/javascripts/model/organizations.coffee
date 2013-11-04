Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Organization = class Organization extends Backbone.Model

  urlRoot: Model.endpoint "organizations"
  modelName: "organization"

  defaults:
    name: ""
    abbreviation: ""
    address: ""
    remarks: ""
    url: ""
    owner: null
    ownerId: null

  schema:
    name:
      type: "Text"
      validators: [ "required" ]
    abbreviation:
      type: "Text"
    address:
      type: "Text"
    remarks:
      type: "TextArea"
    url:
      title: "URL"
      type: "Text"
      validators: [ "url" ]
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


Model.Organizations = class Organizations extends Backbone.PageableCollection

  url: Model.endpoint "organizations"
  model: Model.Organization

  state:
    sortKey: "name"
    order: 1


API =
  getOrganizations: (options) ->
    organizations = new Model.Organizations()
    _.extend organizations.queryParams, options
    dfd = $.Deferred()
    organizations.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getOrganization: (id) ->
    organization = new Model.Organization id: id
    dfd = $.Deferred()
    organization.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "organizations:fetch", (options) -> API.getOrganizations options
Toruzou.reqres.setHandler "organization:fetch", (id) -> API.getOrganization id
