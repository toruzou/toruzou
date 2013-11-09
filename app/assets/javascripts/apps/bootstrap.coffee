Bootstrap = Toruzou.module "Bootstrap"

class Bootstrap.Launcher

  constructor: ->
    Toruzou.on "initialize:after", =>
      @initializeApplication()
      @launchApplication()

  initializeApplication: ->
    @setupRegions()
    @setupLayouts()
    @setupLoadingView()

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
        when "unauthenticated"
          Toruzou.execute "layout:application:header:hide"
          Toruzou.mainRegion.$el.addClass "full-screen"
        else
          throw new Error "unexpected layout: #{layout}"

  setupLoadingView: ->
    sync = Backbone.sync
    Backbone.sync = (method, model, options) ->
      options.beforeSend = _.wrap options.beforeSend, (beforeSend, xhr) ->
        Toruzou.loadingRegion.show new Toruzou.Common.LoadingView()
        beforeSend @, xhr if beforeSend
      options.complete = _.wrap options.complete, (complete, xhr, status) ->
        Toruzou.loadingRegion.close()
        complete @, xhr, status if complete
      sync method, model, options

  launchApplication: ->
    @launch Toruzou.Configuration.root
    if Backbone.history.fragment is ""
      Toruzou.execute "show:users:signIn"

  launch: (root) ->
    @handleAnchors root
    Backbone.history.start pushState: true, root: root

  handleAnchors: (root) ->
    selector = "a[href]:not([data-bypass])"
    $(document).on "click", selector, (e) ->
      href =
        prop: $(@).prop "href"
        attr: $(@).attr "href"
      base = "#{location.protocol}//#{location.host}#{root}"
      if _.str.startsWith href.prop, base
        e.preventDefault()
        Backbone.history.navigate href.attr, true

Toruzou.on "authentication:signedIn", (route) ->
  route or= Toruzou.request "route:timeline:list"
  route = route.slice(1) if _.str.startsWith route, "/"
  Toruzou.location route

Toruzou.addInitializer -> new Bootstrap.Launcher()
