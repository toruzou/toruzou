Bootstrap = Toruzou.module "Bootstrap"

unauthorizedHandler = (xhr, status, e) ->
  if xhr and xhr.status is 401
    execute "error:unauthorized", xhr, status, e

forbiddenHandler = (xhr, status, e) ->
  if xhr and xhr.status is 403
    execute "error:forbidden", xhr, status, e

notFoundHandler = (xhr, status, e) ->
  if xhr and xhr.status is 404
    execute "error:notFound", xhr, status, e

unknownErrorHandler = (xhr, status, e) ->
  if xhr and xhr.status is 500
    execute "error:unknown", xhr, status, e

execute = (event, xhr, status, e) ->
  message = response: Toruzou.Common.Helpers.parseJSON xhr
  message.route = Toruzou.getCurrentRoute()
  Toruzou.execute event, message

class Bootstrap.Launcher

  constructor: ->
    Toruzou.on "initialize:after", =>
      @initializeApplication()
      @launchApplication()

  initializeApplication: ->
    @setupRegions()
    @setupLayouts()
    @setupSync()

  setupRegions: ->
    Toruzou.addRegions
      headerRegion: "#header-region"
      mainRegion: "#main-region"
      loadingRegion: "#loading-region"
      dialogRegion: Toruzou.Common.DialogRegion.extend el: "#dialog-region"

  setupLayouts: ->
    Toruzou.commands.setHandler "set:layout", (layout) ->
      switch layout
        when "application"
          Toruzou.execute "layout:application:header:show"
          Toruzou.mainRegion.$el.removeClass "full-screen"
        else
          Toruzou.execute "layout:application:header:hide"
          Toruzou.mainRegion.$el.addClass "full-screen"

  setupSync: ->
    sync = Backbone.sync
    Backbone.sync = (method, model, options) ->
      errorHandlers = [
        options.unauthorized or unauthorizedHandler
        options.forbidden or forbiddenHandler
        options.notFound or notFoundHandler
        options.unknownError or unknownErrorHandler
      ]
      errorHandlers.unshift options.error if options.error
      options.error = (xhr, status, e) -> handler(xhr, status, e) for handler in errorHandlers
      options.beforeSend = _.wrap options.beforeSend, (beforeSend, xhr) ->
        Toruzou.loadingRegion.show new Toruzou.Common.LoadingView()
        beforeSend @, xhr if beforeSend
      options.complete = _.wrap options.complete, (complete, xhr, status) ->
        Toruzou.loadingRegion.close()
        complete @, xhr, status if complete
      sync method, model, options

  launchApplication: ->
    @launch Toruzou.Configuration.root

  launch: (root) ->
    @handleAnchors root
    Backbone.history.start pushState: true, root: root

  handleAnchors: (root) ->
    selector = "a[href]:not([data-bypass])"
    $(document).on "click", selector, (e) ->
      href =
        prop: $(@).prop "href"
        attr: $(@).attr "href"

      # Prevent from moving to Timeline when paginate works.
      return if href.attr is "#"

      base = "#{location.protocol}//#{location.host}#{root}"
      if _.str.startsWith href.prop, base
        e.preventDefault()
        Toruzou.navigate href.attr, trigger: true

Toruzou.on "authentication:signedIn", ->
  Toruzou.location ""

Toruzou.addInitializer -> new Bootstrap.Launcher()
