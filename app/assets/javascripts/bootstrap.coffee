# FIXME: This is ugly. Should separete.

root = exports ? this
Toruzou = root.Toruzou = new Marionette.Application()

Toruzou.Launcher =
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

Toruzou.navigate = (route, options) ->
  options or= {}
  Backbone.history.navigate(route, options)

Toruzou.addRegions
  mainRegion: "#application"
  
Toruzou.on "initialize:after", ->
  Toruzou.Launcher.launch "/"
  if Backbone.history.fragment is ""
    Toruzou.trigger "users:signIn"