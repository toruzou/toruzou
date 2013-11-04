Edit = Toruzou.module "Organizations.Edit"

class Edit.View extends Toruzou.Organizations.Common.FormView

  constructor: (options) ->
    options = _.extend options or= {}, title: "Edit Organization"
    super options
