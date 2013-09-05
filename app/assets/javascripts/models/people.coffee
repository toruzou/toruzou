Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Person = class Person extends Backbone.Model

    urlRoot: Models.endpoint "people"
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
      organizationId: Models.Schema.organization
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
      ownerId: $.extend true, Models.Schema.user, title: "Owner"


  Models.People = class People extends Backbone.PageableCollection

    url: Models.endpoint "people"
    model: Models.Person


  API =
    getPeople: (options) ->
      organizations = new Models.People()
      _.extend organizations.queryParams, options
      dfd = $.Deferred()
      organizations.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getPerson: (id) ->
      person = new Models.Person id: id
      dfd = $.Deferred()
      person.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "people:fetch", (options) -> API.getPeople options
  Toruzou.reqres.setHandler "person:fetch", (id) -> API.getPerson id