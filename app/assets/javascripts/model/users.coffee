Model = Toruzou.module "Model"

Model.Session = class Session extends Backbone.Model

  urlRoot: Model.endpoint "session"

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
  createCredential: (options) ->
    new Model.UserCredential options
  createRegistration: (options) ->
    new Model.UserRegistration options
  createPasswordRecovery: (options) ->
    new Model.UserPasswordRecovery options
  createUser: (options) ->
    new Model.User options
  createUsers: (options) ->
    collection = new Model.Users()
    _.extend collection.queryParams, options
    collection
  getSession: ->
    new Model.Session().fetch()
  getUser: (id) ->
    model = API.createUser id: id
    model.fetch()
  getUsers: (options) ->
    collection = API.createUsers options
    collection.fetch()
  follow: (id) ->
    model = API.createUser id: id
    model.save url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createUser id: id
    model.destroy url: "#{_.result model, "url"}/following"

Toruzou.reqres.setHandler "user:credential:new", API.createCredential
Toruzou.reqres.setHandler "user:registration:new", API.createRegistration
Toruzou.reqres.setHandler "user:recovery:new", API.createPasswordRecovery
Toruzou.reqres.setHandler "user:new", API.createUser
Toruzou.reqres.setHandler "users:new", API.createUsers
Toruzou.reqres.setHandler "user:fetch", API.getUser
Toruzou.reqres.setHandler "users:fetch", API.getUsers
Toruzou.reqres.setHandler "user:follow", API.follow
Toruzou.reqres.setHandler "user:unfollow", API.unfollow
Toruzou.reqres.setHandler "session:fetch", API.getSession
