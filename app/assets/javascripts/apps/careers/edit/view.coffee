Toruzou.module "Careers.Edit", (Edit, Toruzou, Backbone, Marionette, $, _) ->

  class Edit.View extends Toruzou.Careers.Common.EditFormView

    constructor: (options) ->
      options = _.extend options or= {}, title: "Edit Career"
      super options
