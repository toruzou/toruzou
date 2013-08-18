Toruzou.module "Users.SignUp", (SignUp, Toruzou, Backbone, Marionette, $, _) ->

  class SignUp.View extends Toruzou.Common.FormView

    template: "users/sign_up"
    events:
      "submit form": "signUp"
    schema:
      email:
        editorAttrs:
          placeholder: "Your email"
      password:
        editorAttrs:
          placeholder: "Your password"
      passwordConfirmation:
        editorAttrs:
          placeholder: "Re-enter your password"

    constructor: ->
      super model: new Toruzou.Models.UserRegistration()

    signUp: (e) ->
      e.preventDefault()
      Toruzou.Common.Helpers.Notification.clear @$el
      @commit
        success: (model, response) ->
          Toruzou.curentUser = new Toruzou.Models.User response
          Toruzou.trigger "authentication:signed_in"
        error: (model, response) ->
          result = $.parseJSON response.responseText
          options = {}
          options.title = "Unable to complete sign up"
          options.messages = []
          for property, errors of result.errors
            title = @$el.find("#label-#{property}")?.text() or _.str.capitalize property
            for error in errors
              options.messages.push "#{title} #{error}"
          @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error options
