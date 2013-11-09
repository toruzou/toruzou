Common = Toruzou.module "Users.Common"

class Common.UnauthenticatedLayout extends Marionette.Layout

  template: "layouts/unauthenticated"
  className: "unauthenticated-container"

  regions:
    contentsRegion: "#unauthenticated-contents-region"
