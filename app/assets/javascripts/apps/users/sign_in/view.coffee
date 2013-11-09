SignIn = Toruzou.module "Users.SignIn"

class SignIn.FormView extends Toruzou.Common.FormView

  template: "users/sign_in"
  events:
    "submit form": "signIn"
  schema:
    login:
      editorAttrs:
        placeholder: "Your username or email"
    password:
      help: "<a href=\"users/retrieve_password\" class=\"help\">(Forgot password ?)</a>"
      editorAttrs:
        placeholder: "Your password"

  constructor: (options = {}) ->
    options.model = Toruzou.request "user:credential:new"
    super options

  signIn: (e) ->
    e.preventDefault()
    @commit().done => Toruzou.trigger "authentication:signedIn"

class SignIn.View extends Toruzou.Users.Common.UnauthenticatedLayout

  onShow: ->
    @contentsRegion.show new SignIn.FormView()
