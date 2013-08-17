Toruzou.module "Users", (Users, Toruzou, Backbone, Marionette, $, _) ->

  Users.Router = class UsersRouter extends Marionette.AppRouter
    appRoutes:
      "sign_in": "signIn"
      "sign_up": "signUp"
      "retrieve_password": "retrievePassword"
      "users/cancel": "cancelRegistration"
      "users/edit": "edit"
      "users/password/new": "newPassword"
      "users/password/edit": "editPassword"

  API =
    signIn: ->
      Users.SignIn.Controller.show()
    signUp: ->
      Users.SignUp.Controller.show()
    retrievePassword: ->
      Users.RetrievePassword.Controller.show()
    cancelRegistration: ->
      console.log "cancel-registration"
    edit: ->
      console.log "edit"
    newPassword: ->
      console.log "new-password"
    editPassword: ->
      console.log "edit-password"

  Toruzou.on "users:signIn", ->
    Toruzou.navigate "sign_in"
    API.signIn()

  Toruzou.addInitializer -> new Users.Router controller: API
