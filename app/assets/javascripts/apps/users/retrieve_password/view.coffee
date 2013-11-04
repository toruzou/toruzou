RetrievePassword = Toruzou.module "Users.RetrievePassword"

class RetrievePassword.View extends Toruzou.Common.FormView

  template: "users/retrieve_password"
  events:
    "submit form": "retrievePassword"
  schema:
    email:
      editorAttrs:
        placeholder: "Your email"

  constructor: ->
    super model: new Toruzou.Models.UserPasswordRecovery()

  retrievePassword: (e) ->
    e.preventDefault()
    @commit
      success: (model, response) =>
        @$el.find("form").prepend Toruzou.Common.Helpers.Notification.success
          message: "Instructions for resetting your password have been sent. Please check your email for further instructions."
      error: (model, response) =>
        @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error
          message: "The email you entered did not match an email in our database."
