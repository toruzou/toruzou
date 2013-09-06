Toruzou.module "People.New", (New, Toruzou, Backbone, Marionette, $, _) ->

  class New.View extends Toruzou.People.Common.FormView

    constructor: (options) ->
      options or= {}
      options.title or= "New Person"
      options.model or= new Toruzou.Models.Person()
      super options
