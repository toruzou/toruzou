Toruzou.module "Organizations.New", (New, Toruzou, Backbone, Marionette, $, _) ->

  class New.View extends Toruzou.Organizations.Common.FormView

    constructor: (options) ->
      options = _.extend options or= {},
        title: "New Organization"
        model: new Toruzou.Models.Organization()
      super options
