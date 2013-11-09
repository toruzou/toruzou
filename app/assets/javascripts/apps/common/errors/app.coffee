Errors = Toruzou.module "Errors"

strip = (fragment) -> fragment.replace /^(\#|\/)/, ""
API = Errors.API =

  notFound: (message) ->
    Toruzou.mainRegion.show new Errors.View.NotFoundView()
    Toruzou.execute "set:layout", "error"

  unauthorized: (message) ->
    signInRoute = Toruzou.request "route:users:signIn"
    route = if message.route then strip(message.route) else signInRoute
    if Toruzou.getCurrentRoute() isnt signInRoute
      Toruzou.execute "show:users:signIn", message.route

  forbidden: (message) ->
    Toruzou.mainRegion.show new Errors.View.ForbiddenView()
    Toruzou.execute "set:layout", "error"

  unknownError: (message) ->
    Toruzou.mainRegion.show new Errors.View.UnknownErrorView
    Toruzou.execute "set:layout", "error"

class Errors.Router extends Marionette.AppRouter

  appRoutes:
    "*notFound": "notFound"

Toruzou.commands.setHandler "error:notFound", API.notFound
Toruzou.commands.setHandler "error:unauthorized", API.unauthorized
Toruzou.commands.setHandler "error:forbidden", API.forbidden
Toruzou.commands.setHandler "error:unknown", API.unknownError

Toruzou.addInitializer -> new Errors.Router controller: API
