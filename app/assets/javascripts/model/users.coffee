Model = Toruzou.module "Model"

class Model.Account extends Backbone.Model

  url: Model.endpoint "account"

class Model.Following extends Backbone.Model

class Model.Followings extends Backbone.PageableCollection

  state:
    sortKey: "updated_at"
    order: 1

class Model.User extends Backbone.Model

  urlRoot: Model.endpoint "users"

  createNote: ->
    note = new Model.Note()
    note.subject = @
    note

  followings: ->
    followings = new Model.Followings()
    followings.url = Model.endpoint "users/#{@get "id"}/followings"
    followings

class Model.Users extends Backbone.PageableCollection

  url: Model.endpoint "users"
  model: Model.User

  state:
    sortKey: "name"
    order: 1

# TODO Refine validators (character length etc.)

class Model.UserCredential extends Backbone.Model

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


class Model.SignOut extends Backbone.Model

  url: Model.endpoint "users/sign_out"

  isNew: -> false


class Model.UserRegistration extends Backbone.Model

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


class Model.UserPasswordRecovery extends Backbone.Model

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
  getUser: (id) ->
    model = API.createUser id: id
    model.fetch()
  getUsers: (options) ->
    collection = API.createUsers options
    collection.fetch()
  getFollowings: (id) ->
    model = API.createUser id: id
    model.followings().fetch url: "#{_.result model, "url"}/followings"
  getAccount: ->
    new Model.Account().fetch()
  signOut: ->
    new Model.SignOut().destroy()
  follow: (id) ->
    model = API.createUser id: id
    model.save url: "#{_.result model, "url"}/following"
  unfollow: (id) ->
    model = API.createUser id: id
    model.destro

    # TODO 専用の Followings コレクションを作って state をつくる

Toruzou.reqres.setHandler "user:credential:new", API.createCredential
Toruzou.reqres.setHandler "user:registration:new", API.createRegistration
Toruzou.reqres.setHandler "user:recovery:new", API.createPasswordRecovery
Toruzou.reqres.setHandler "user:new", API.createUser
Toruzou.reqres.setHandler "users:new", API.createUsers
Toruzou.reqres.setHandler "user:fetch", API.getUser
Toruzou.reqres.setHandler "users:fetch", API.getUsers
Toruzou.reqres.setHandler "user:followings:fetch", API.getFollowings
Toruzou.reqres.setHandler "user:follow", API.follow
Toruzou.reqres.setHandler "user:unfollow", API.unfollow
Toruzou.reqres.setHandler "account:fetch", API.getAccount
Toruzou.reqres.setHandler "signOut", API.signOut
