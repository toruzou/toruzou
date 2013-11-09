Users = Toruzou.module "Users"

class Users.Router extends Toruzou.Common.ResourceRouter
  resource: "users"
  appRoutes:
    "/sign_in": "signIn"
    "/sign_up": "signUp"
    "/retrieve_password": "retrievePassword"
    "/account(/*slug)": "account"
    "": "list"
    "/:id(/*slug)": "show"

API =
  signIn: ->
    Users.SignIn.Controller.show()
  signUp: ->
    Users.SignUp.Controller.show()
  retrievePassword: ->
    Users.RetrievePassword.Controller.show()
  list: ->
    Users.Index.Controller.list()
  show: (id, slug) ->
    Users.Show.Controller.show id, slug
  account: (slug) ->
    Users.Account.Controller.show slug

Toruzou.addInitializer -> new Users.Router controller: API
