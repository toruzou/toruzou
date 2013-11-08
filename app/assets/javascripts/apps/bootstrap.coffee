Bootstrap = Toruzou.module "Bootstrap"

class Bootstrap.Launcher

  constructor: ->
    Toruzou.on "initialize:after", =>
      @initializeApplication()
      @launchApplication()

  initializeApplication: ->
    Toruzou.addRegions
      mainRegion: "#application"
      loadingRegion: "#loading-region"
      dialogRegion: Toruzou.Common.DialogRegion.extend el: "#dialog-region"
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

Toruzou.on "authentication:signedIn", -> Toruzou.execute "show:timeline:list"
Toruzou.addInitializer -> new Bootstrap.Launcher()
