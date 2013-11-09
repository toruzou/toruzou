Common = Toruzou.module "Common"

class UnauthenticatedLayout extends Marionette.Layout

  template: "layouts/unauthenticated"
  className: "full-screen"

  regions:
    mainRegion: "#unauthenticated-region"

  show: ->
    Toruzou.mainRegion.show @
    @


class TopbarView extends Marionette.ItemView

  template: "layouts/topbar"
  events:
    "click #signOut-button": "signOut"

  signOut: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.when(Toruzou.request "signOut").done -> Toruzou.location ""


class ApplicationLayout extends Marionette.Layout

  template: "layouts/application"
  className: "full-screen"

  regions:
    headerRegion: "#header-region"
    mainRegion: "#main-region"

  show: ->
    Toruzou.mainRegion.show @
    @

  onShow: ->
    @headerRegion.show @topbarView or= new TopbarView()
    # FIXME : should be more efficient
    $(document).foundation "off"
    $(document).foundation()


Common.UnauthenticatedLayout = new UnauthenticatedLayout()
Common.ApplicationLayout = new ApplicationLayout()  
