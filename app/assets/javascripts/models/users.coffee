Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  Models.User = class User extends Backbone.Model


  Models.UserSession = class UserSession extends Backbone.Model

    url: "users/sign_in"
    modelName: "user"

    defaults:
      "email": ""
      "password": ""

    schema:
      email:
        type: "Text" # FIXME BBF should support HTML5 email attribute
        validators: [ "required", "email" ]
      password:
        type: "Password"
        validators: [ "required" ]


  Models.UserRegistration = class UserRegistration extends Backbone.Model

    url: "users"
    modelName: "user"

    defaults:
      "email": ""
      "password": ""
      "passwordConfirmation": ""

    schema:
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

    url: "users/password"
    modelName: "user"

    defaults:
      "email": ""

    schema:
      email:
        type: "Text" # FIXME BBF should support HTML5 email attribute
        validators: [ "required", "email" ]