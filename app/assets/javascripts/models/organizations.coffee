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
        selectize:
          valueField: "id"
          labelField: "username"
          searchField: "username"
          create: false
          load: (query, callback) ->
            return callback() unless query.length
            $.when(Toruzou.request "users:fetch", query).done (users) -> callback _.map(users.models, (user) -> user.toJSON())

    toJSON: ->
      # FIXME Ugly, but this is needed for adapting server API
      attributes = super
      Models.renameProperty attributes, "#{@modelName}.owner", "#{@modelName}.owner_id"
      attributes


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