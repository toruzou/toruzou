Users = Toruzou.module "Users"

class Users.Router extends Toruzou.Common.ResourceRouter
  resource: "users"
  appRoutes:
    "/sign_in": "signIn"
    "/sign_up": "signUp"
    "/retrieve_password": "retrievePassword"
    "": "list"
    "/:id(/*slug)": "show"
    "/cancel": "cancelRegistration"
    "/edit": "edit"
    "/password/new": "newPassword"
    "/password/edit": "editPassword"

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
  # TODO
  cancelRegistration: ->
    console.log "cancel-registration"
  edit: ->
    console.log "edit"
  newPassword: ->
    console.log "new-password"
  editPassword: ->
    console.log "edit-password"

Toruzou.addInitializer -> new Users.Router controller: API
