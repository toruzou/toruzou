Toruzou.module "Deals.New", (New, Toruzou, Backbone, Marionette, $, _) ->

  class New.View extends Toruzou.Deals.Common.FormView

    constructor: (options) ->
      options or= {}
      options.title or= "New Deal"
      options.model or= new Toruzou.Models.Deal()
      super options
