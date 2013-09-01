Toruzou.module "Organizations.Edit", (Edit, Toruzou, Backbone, Marionette, $, _) ->

  class Edit.View extends Toruzou.Organizations.Common.FormView

    constructor: (options) ->
      options = _.extend options or= {}, title: "Edit Organization"
      super options
