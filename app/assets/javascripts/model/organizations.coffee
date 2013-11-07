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
  createOrganization: (options) ->
    new Model.Organization options
  createOrganizations: (options) ->
    collection = new Model.Organizations()
    _.extend collection.queryParams, options
    collection
  getOrganization: (id) ->
    model = API.createOrganization id: id
    model.fetch()
  getOrganizations: (options) ->
    collection = API.createOrganizations options
    collection.fetch()
  follow: (id) ->
    model = API.createOrganization id: id
    model.save url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createOrganization id: id
    model.destroy url: "#{_.result model, "url"}/following"

Toruzou.reqres.setHandler "organization:new", API.createOrganization
Toruzou.reqres.setHandler "organizations:new", API.createOrganizations
Toruzou.reqres.setHandler "organization:fetch", API.getOrganization
Toruzou.reqres.setHandler "organizations:fetch", API.getOrganizations
Toruzou.reqres.setHandler "organization:follow", API.follow
Toruzou.reqres.setHandler "organization:unfollow", API.unfollow
