Common = Toruzou.module "Common"

class Common.ResourceRouter extends Marionette.AppRouter

  route: (route, name, callback) ->
    route = route.substr(1, route.length) if route.substr(0, 1) is "/"
    resource = _.result @, "resource"
    resourceRoute = resource
    separator = if resource.slice(-1) is "/" then "" else "/"
    (if route.substr(0, 1) isnt "?" then resourceRoute += (separator + route) else resourceRoute += route) if route and route.length > 0
    @bindHandlers resourceRoute, name
    super rr, name, callback for rr in [ resourceRoute, "#{resourceRoute}/" ]

  bindHandlers: (resourceRoute, name) ->
    @bindRouteHandler resourceRoute, name
    @bindLinkToHandler resourceRoute, name
    @bindNavigateHandler resourceRoute, name
    @bindShowHandler resourceRoute, name

  bindRouteHandler: (resourceRoute, name) ->
    Toruzou.reqres.setHandler "route:#{@resource}:#{name}", (params...) => @routeFor(resourceRoute, params...)

  bindLinkToHandler: (resourceRoute, name) ->
    Toruzou.reqres.setHandler "linkTo:#{@resource}:#{name}", (name, params...) => "<a href=\"#{@routeFor(resourceRoute, params...)}\">#{name}</a>"

  bindNavigateHandler: (resourceRoute, name) ->
    Toruzou.commands.setHandler "navigate:#{@resource}:#{name}", (params...) => Toruzou.navigate @routeFor(resourceRoute, params...)

  bindShowHandler: (resourceRoute, name) ->
    Toruzou.commands.setHandler "show:#{@resource}:#{name}", (params...) =>
      Toruzou.navigate @routeFor(resourceRoute, params...)
      @_getController()?[name]?(params...)

  routeFor: (resourceRoute, params...) ->
    route = Toruzou.linkTo resourceRoute
    _.each params, (param) ->
      if _.isArray param
        param = _.map(param, encodeURIComponent).join "/"
      else
        param = encodeURIComponent param
      route = route.replace /(?:\:|\*)[^\/]+/, param
    route = route.replace /\(/, ""
    route = route.replace /(?:\:|\*).*$/, ""
    route
