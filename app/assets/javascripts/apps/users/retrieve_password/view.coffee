Toruzou.module "Users.RetrievePassword", (RetrievePassword, Toruzou, Backbone, Marionette, $, _) ->

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
        success: (model, response) ->
          @$el.find("form").prepend Toruzou.Common.Helpers.success "Instructions for resetting your password have been sent. Please check your email for further instructions."
        error: (model, response) ->
          @$el.find("form").prepend Toruzou.Common.Helpers.error "The email you entered did not match an email in our database."
