Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

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
      $(document).foundation "off"
      $(document).foundation()


  Common.UnauthenticatedLayout = new UnauthenticatedLayout()
  Common.ApplicationLayout = new ApplicationLayout()  
