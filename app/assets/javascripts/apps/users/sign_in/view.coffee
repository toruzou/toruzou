SignIn = Toruzou.module "Users.SignIn"

class SignIn.View extends Toruzou.Common.FormView

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

  constructor: ->
    model = Toruzou.request "user:credential:new"
    super model: model

  signIn: (e) ->
    e.preventDefault()
    @commit().done => @signInToRoute()

  signInToRoute: ->
    route = if @options.route then "#{@options.route}" else "timeline"
    Toruzou.navigate route, trigger: true
