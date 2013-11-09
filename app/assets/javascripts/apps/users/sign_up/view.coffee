SignUp = Toruzou.module "Users.SignUp"

class SignUp.FormView extends Toruzou.Common.FormView

  template: "users/sign_up"
  events:
    "submit form": "signUp"
  schema:
    name:
      editorAttrs:
        placeholder: "Username"
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
    model = Toruzou.request "user:registration:new"
    super model: model

  signUp: (e) ->
    e.preventDefault()
    @commit
      success: (model, response) ->
        Toruzou.curentUser = Toruzou.request "user:new", response
        Toruzou.trigger "authentication:signedIn"
        
class SignUp.View extends Toruzou.Users.Common.UnauthenticatedLayout

  onShow: ->
    @contentsRegion.show new SignUp.FormView()
