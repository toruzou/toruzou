Toruzou.module "Users", (Users, Toruzou, Backbone, Marionette, $, _) ->

  Users.Router = class UsersRouter extends Marionette.AppRouter
    appRoutes:
      "sign_in": "signIn"
      "sign_up": "signUp"
      "retrieve_password": "retrievePassword"
      "users": "listUsers"
      "users/:id": "showUser"
      "users/:id/*slug": "showUser"
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
    listUsers: ->
      Users.Index.Controller.listUsers()
    showUser: (id, slug) ->
      Users.Show.Controller.showUser id, slug
    # TODO
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

  Toruzou.on "user:sectionChanged", (options) ->
    Toruzou.navigate "users/#{options.id}/#{options.slug}"

  Toruzou.addInitializer -> new Users.Router controller: API
