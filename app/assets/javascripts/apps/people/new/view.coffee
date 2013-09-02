Toruzou.module "People.New", (New, Toruzou, Backbone, Marionette, $, _) ->

  class New.View extends Toruzou.People.Common.FormView

    constructor: (options) ->
      options = _.extend options or= {},
        title: "New Person"
        model: new Toruzou.Models.Person()
      super options
