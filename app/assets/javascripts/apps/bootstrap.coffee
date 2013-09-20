Toruzou.module "Bootstrap", (Bootstrap, Toruzou, Backbone, Marionette, $, _) ->

  class Bootstrap.Launcher

    constructor: ->
      Toruzou.on "initialize:after", =>
        @initializeApplication()
        @launchApplication()

    initializeApplication: ->
      Toruzou.addRegions
        mainRegion: "#application"
        dialogRegion: Toruzou.Common.DialogRegion.extend el: "#dialog-region"

    launchApplication: ->
      @launch Toruzou.Configuration.root
      if Backbone.history.fragment is ""
        Toruzou.trigger "users:signIn"

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

  Toruzou.addInitializer -> new Bootstrap.Launcher()
