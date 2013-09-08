Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  Models.Schema =
    
    user:
      title: "User"
      type: "Selectize"
      restore: (model) ->
        attributes = model.get "owner"
        if attributes
          model = if attributes instanceof Backbone.Model then attributes else new Models.User attributes
          {
            value: model.get "id"
            data: model.serialize()
          }
      selectize:
        valueField: "id"
        labelField: "username"
        searchField: "username"
        create: false
        load: (query, callback) ->
          return callback() unless query.length
          $.when(Toruzou.request "users:fetch", username: query).done (users) -> callback _.map(users.models, (user) -> user.serialize())

    organization:
      title: "Organization"
      type: "Selectize"
      restore: (model) ->
        attributes = model.get "organization"
        if attributes
          model = if attributes instanceof Backbone.Model then attributes else new Models.Organization attributes
          {
            value: model.get "id"
            data: model.serialize()
          }
      selectize:
        valueField: "id"
        labelField: "name"
        searchField: "name"
        create: (input, callback) ->
          return callback() unless input.length
          organization = new Toruzou.Models.Organization()
          organization.save "name", input, success: (organization) => callback organization.serialize()
          undefined
        load: (query, callback) ->
          return callback() unless query.length
          $.when(Toruzou.request "organizations:fetch", name: query).done (organizations) -> callback _.map(organizations.models, (organization) -> organization.serialize())

    deal:
      title: "Deal"
      type: "Selectize"
      restore: (model) ->
        attributes = model.get "deal"
        if attributes
          model = if attributes instanceof Backbone.Model then attributes else new Models.Deal attributes
          {
            value: model.get "id"
            data: model.serialize()
          }
      selectize:
        valueField: "id"
        labelField: "name"
        searchField: "name"
        create: (input, callback) ->
          return callback() unless input.length
          deal = new Toruzou.Models.Deal()
          deal.save "name", input, success: (deal) => callback deal.serialize()
          undefined
        load: (query, callback) ->
          return callback() unless query.length
          $.when(Toruzou.request "deals:fetch", name: query).done (deals) -> callback _.map(deals.models, (deal) -> deal.serialize())

  Object.freeze? Models.Schema
