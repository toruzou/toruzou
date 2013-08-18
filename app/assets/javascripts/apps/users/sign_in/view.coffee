Toruzou.module "Users.SignIn", (SignIn, Toruzou, Backbone, Marionette, $, _) ->

  class SignIn.View extends Toruzou.Common.FormView

    template: "users/sign_in"
    events:
      "submit form": "signIn"
    schema:
      email:
        editorAttrs:
          placeholder: "Your email"
      password:
        help: "<a href=\"retrieve_password\" class=\"help\">(Forgot password ?)</a>"
        editorAttrs:
          placeholder: "Your password"

    constructor: ->
      super model: new Toruzou.Models.UserSession()

    signIn: (e) ->
      e.preventDefault()
      Toruzou.Common.Helpers.Notification.clear @$el
      @commit
        success: (model, response) ->
          Toruzou.curentUser = new Toruzou.Models.User response
          Toruzou.trigger "authentication:signed_in"
        error: (model, response) ->
          result = $.parseJSON response.responseText
          @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error
            message: result.error
