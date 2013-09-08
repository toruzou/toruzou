Toruzou.module "Deals.Edit", (Edit, Toruzou, Backbone, Marionette, $, _) ->

  class Edit.View extends Toruzou.Deals.Common.FormView

    constructor: (options) ->
      options = _.extend options or= {}, title: "Edit Deal"
      super options
