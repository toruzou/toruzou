Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  Models.User = class User extends Backbone.Model

    urlRoot: Models.endpoint "users"

    createNote: ->
      note = new Models.Note()
      note.subject = @
      note

  Models.Users = class Users extends Backbone.PageableCollection

    url: Models.endpoint "users"
    model: Models.User

    state:
      sortKey: "name"
      order: 1

  # TODO Refine validators (character length etc.)

  Models.UserCredential = class UserCredential extends Backbone.Model

    url: Models.endpoint "users/sign_in"
    modelName: "user"

    defaults:
      "login": ""
      "password": ""

    schema:
      login:
        type: "Text"
        title: "Username or Email"
        validators: [ "required" ]
      password:
        type: "Password"
        validators: [ "required" ]


  Models.UserRegistration = class UserRegistration extends Backbone.Model

    url: Models.endpoint "users"
    modelName: "user"

    defaults:
      "name": ""
      "email": ""
      "password": ""
      "passwordConfirmation": ""

    schema:
      name:
        type: "Text"
        validators: [ "required" ]
      email:
        type: "Text"
        validators: [ "required", "email" ]
      password:
        type: "Password"
        validators: [ "required" ]
      passwordConfirmation:
        type: "Password"
        validators: [
          "required"
          type: "match", field: "password", message: "Passwords must match."
        ]


  Models.UserPasswordRecovery = class UserPasswordRecovery extends Backbone.Model

    url: Models.endpoint "users/password"
    modelName: "user"

    defaults:
      "email": ""

    schema:
      email:
        type: "Text"
        validators: [ "required", "email" ]


  API =
    getUsers: (options) ->
      users = new Models.Users()
      _.extend users.queryParams, options
      dfd = $.Deferred()
      users.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getUser: (id) ->
      user = new Models.User id: id
      dfd = $.Deferred()
      user.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "users:fetch", (options) -> API.getUsers options
  Toruzou.reqres.setHandler "user:fetch", (id) -> API.getUser id
