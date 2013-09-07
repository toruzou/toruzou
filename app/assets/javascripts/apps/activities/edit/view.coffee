Toruzou.module "Activities.Edit", (Edit, Toruzou, Backbone, Marionette, $, _) ->

  class Edit.View extends Toruzou.Activities.Common.FormView

    constructor: (options) ->
      options = _.extend options or= {}, title: "Edit Activity"
      super options
