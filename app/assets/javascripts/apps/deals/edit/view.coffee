Edit = Toruzou.module "Deals.Edit"

class Edit.View extends Toruzou.Deals.Common.FormView

  constructor: (options) ->
    options = _.extend options or= {}, title: "Edit Deal"
    super options
