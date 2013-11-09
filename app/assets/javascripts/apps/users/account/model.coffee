Model = Toruzou.module "Users.Account.Model"

class Model.Edit extends Backbone.Model

  url: Toruzou.Model.endpoint "account"
  modelName: "user"

  defaults:
    "name": ""
    "email": ""

  schema:
    name:
      type: "Text"
      editorAttrs:
        placeholder: "Username"
    email:
      type: "Text"
      editorAttrs:
        placeholder: "Email"

class Model.ChangePassword extends Backbone.Model

  url: Toruzou.Model.endpoint "account/password"
  modelName: "user"

  isNew: -> false

  defaults:
    "currentPassword": ""
    "password": ""
    "passwordConfirmation": ""

  schema:
    currentPassword:
      type: "Password"
      validators: [ "required" ]
      editorAttrs:
        placeholder: "Current password"
    password:
      type: "Password"
      validators: [ "required" ]
      editorAttrs:
        placeholder: "New password"
    passwordConfirmation:
      type: "Password"
      validators: [
        "required"
        type: "match", field: "password", message: "Passwords must match."
      ]
      editorAttrs:
        placeholder: "Re-enter new password"
      