Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Organization = class Organization extends Backbone.Model

    urlRoot: Models.endpoint "organizations"

    defaults:
      name: ""
      abbreviation: ""
      address: ""
      remarks: ""
      url: ""

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
        # FIXME Should be a url type and its field should have a prefix like `http://`
        # FIXME Should validate if the text is url
        type: "Text"
      owner:
        type: "Selectize"
        # TODO Should configure for searching remote data source.
        options: [
          { val: "1", label: "User 1" },
          { val: "2", label: "User 2" }
        ]
        selectize:
          create: true


  Models.Organizations = class Organizations extends Backbone.PageableCollection

    url: Models.endpoint "organizations"
    model: Models.Organization


  API =
    getOrganizations: ->
      organizations = new Models.Organizations()
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

  Toruzou.reqres.setHandler "organizations:fetch", -> API.getOrganizations()
  Toruzou.reqres.setHandler "organization:fetch", (id) -> API.getOrganization id