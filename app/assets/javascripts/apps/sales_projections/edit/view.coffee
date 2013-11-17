Edit = Toruzou.module "SalesProjections.Edit"

class Edit.View extends Toruzou.SalesProjections.Common.FormView

  constructor: (options = {}) ->
    _.extend options or= {}, title: "Edit Sales Projection"
    super options
