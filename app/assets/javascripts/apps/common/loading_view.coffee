Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.LoadingView extends Backbone.Marionette.ItemView

    template: "common/loading"
    