Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.UnauthenticatedLayout extends Marionette.Layout

    template: "layouts/unauthenticated"
    className: "full-screen"

    regions:
      mainRegion: "#unauthenticated-region"


  class Common.ApplicationLayout extends Marionette.Layout

    template: "layouts/application"
    className: "full-screen"

    regions:
      mainRegion: "#main-region"

    onShow: ->
      $(document).foundation "off"
      $(document).foundation()