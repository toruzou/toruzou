Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Organization = class Organization extends Backbone.Model

    urlRoot: Models.endpoint "organizations"
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
        Models.Schema.User,
        title: "Owner"
        key: "owner"

  Models.Organizations = class Organizations extends Backbone.PageableCollection

    url: Models.endpoint "organizations"
    model: Models.Organization


  API =
    getOrganizations: (options) ->
      organizations = new Models.Organizations()
      _.extend organizations.queryParams, options
      dfd = $.Deferred()
      organizations.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getOrganization: (id) ->
      organization = new Models.Organization id: id
      dfd = $.Deferred()
      organization.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "organizations:fetch", (options) -> API.getOrganizations options
  Toruzou.reqres.setHandler "organization:fetch", (id) -> API.getOrganization id