Model = Toruzou.module "Model"

Model.User = class User extends Backbone.Model

  urlRoot: Model.endpoint "users"

  createNote: ->
    note = new Model.Note()
    note.subject = @
    note

Model.Users = class Users extends Backbone.PageableCollection

  url: Model.endpoint "users"
  model: Model.User

  state:
    sortKey: "name"
    order: 1

# TODO Refine validators (character length etc.)

Model.UserCredential = class UserCredential extends Backbone.Model

  url: Model.endpoint "users/sign_in"
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


Model.UserRegistration = class UserRegistration extends Backbone.Model

  url: Model.endpoint "users"
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


Model.UserPasswordRecovery = class UserPasswordRecovery extends Backbone.Model

  url: Model.endpoint "users/password"
  modelName: "user"

  defaults:
    "email": ""

  schema:
    email:
      type: "Text"
      validators: [ "required", "email" ]


API =
  getUsers: (options) ->
    users = new Model.Users()
    _.extend users.queryParams, options
    dfd = $.Deferred()
    users.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getUser: (id) ->
    user = new Model.User id: id
    dfd = $.Deferred()
    user.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "users:fetch", (options) -> API.getUsers options
Toruzou.reqres.setHandler "user:fetch", (id) -> API.getUser id
