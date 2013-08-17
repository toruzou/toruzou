Toruzou.module "Users.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.UnauthenticatedLayout extends Marionette.Layout

    template: "layouts/unauthenticated"
    className: "full-screen"
    regions:
      mainRegion: "#unauthenticated-region"