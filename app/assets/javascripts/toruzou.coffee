# FIXME: This is ugly. Should separete.

Backbone.Marionette.Region.Dialog = class DialogRegion extends Backbone.Marionette.Region

  onShow: (view) ->
    $modal = @$el.closest("#modal-dialog")
    view.on "close", -> $modal.foundation("reveal", "close")
    $modal.foundation("reveal", "open").on "closed", => @close()

root = exports ? this
Toruzou = root.Toruzou = new Marionette.Application()

Toruzou.Configuration =
  root: "/"
  api:
    version: "v1"

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
  dialogRegion: Marionette.Region.Dialog.extend el: "#dialog-region"
  
Toruzou.on "initialize:after", ->
  Toruzou.Launcher.launch Toruzou.Configuration.root
  if Backbone.history.fragment is ""
    Toruzou.trigger "users:signIn"
    