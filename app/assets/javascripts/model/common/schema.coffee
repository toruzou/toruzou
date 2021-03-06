Model = Toruzou.module "Model"

restoreModel = (attributes, Model) -> if attributes instanceof Backbone.Model then attributes else new Model attributes

Model.Schema =

  User:
    type: "Selectize"
    restore: (model) ->
      attributes = model.get @key
      if attributes
        model = restoreModel attributes, Model.User
        {
          value: model.get "id"
          data: model.serialize()
        }
    selectize:
      valueField: "id"
      labelField: "name"
      searchField: "name"
      create: false
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "users:fetch", name: query).done (users) -> callback _.map(users.models, (user) -> user.serialize())

  Users:
    type: "Selectize"
    restore: (model) ->
      users = model.get @key
      return [] unless users
      users = _.map users, (attributes) -> restoreModel attributes, Model.Person
      {
        value: _.map users, (user) -> user.get "id"
        data: _.map users, (user) -> user.serialize()
      }
    selectize:
      maxItems: null
      valueField: "id"
      labelField: "name"
      searchField: "name"
      create: (input, callback) ->
        return callback() unless input.length
        user = new Toruzou.Model.User()
        user.save("name", input).done (user) => callback user.serialize()
        undefined
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "users:fetch", name: query).done (users) -> callback _.map(users.models, (user) -> user.serialize())

  Organization:
    type: "Selectize"
    restore: (model) ->
      attributes = model.get @key
      if attributes
        model = restoreModel attributes, Model.Organization
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
        organization = new Toruzou.Model.Organization()
        organization.save("name", input).done (organization) => callback organization.serialize()
        undefined
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "organizations:fetch", name: query).done (organizations) -> callback _.map(organizations.models, (organization) -> organization.serialize())

  Deal:
    type: "Selectize"
    restore: (model) ->
      attributes = model.get @key
      if attributes
        model = restoreModel attributes, Model.Deal
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
        deal = new Toruzou.Model.Deal()
        deal.save("name", input).done (deal) => callback deal.serialize()
        undefined
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "deals:fetch", name: query).done (deals) -> callback _.map(deals.models, (deal) -> deal.serialize())

  Person:
    type: "Selectize"
    restore: (model) ->
      attributes = model.get @key
      if attributes
        model = restoreModel attributes, Model.Person
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
        person = new Toruzou.Model.Person()
        person.save("name", input).done (person) => callback person.serialize()
        undefined
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "people:fetch", name: query).done (people) -> callback _.map(people.models, (person) -> person.serialize())

  People:
    type: "Selectize"
    restore: (model) ->
      people = model.get @key
      return [] unless people
      people = _.map people, (attributes) -> restoreModel attributes, Model.Person
      {
        value: _.map people, (person) -> person.get "id"
        data: _.map people, (person) -> person.serialize()
      }
    selectize:
      maxItems: null
      valueField: "id"
      labelField: "name"
      searchField: "name"
      create: (input, callback) ->
        return callback() unless input.length
        person = new Model.Person()
        person.save("name", input).done (person) => callback person.serialize()
        undefined
      load: (query, callback) ->
        return callback() unless query.length
        $.when(Toruzou.request "people:fetch", name: query).done (people) -> callback _.map(people.models, (person) -> person.serialize())

# Object.freeze? Model.Schema
