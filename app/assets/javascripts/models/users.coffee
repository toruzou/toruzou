Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  Models.User = class User extends Backbone.Model

    urlRoot: Models.endpoint "users"


  Models.Users = class Users extends Backbone.PageableCollection

    url: Models.endpoint "users"
    model: Models.User

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
      "username": ""
      "email": ""
      "password": ""
      "passwordConfirmation": ""

    schema:
      username:
        type: "Text"
        validators: [ "required" ]
      email:
        type: "Text" # FIXME BBF should support HTML5 email attribute
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
        type: "Text" # FIXME BBF should support HTML5 email attribute
        validators: [ "required", "email" ]


  API =
    getUsers: (q) ->
      users = new Models.Users()
      dfd = $.Deferred()
      users.fetch
        data: $.param q: q
        success: (collection) -> dfd.resolve collection
      dfd.promise()

  Toruzou.reqres.setHandler "users:fetch", (q) -> API.getUsers q
