New = Toruzou.module "SalesProjections.New"

class New.View extends Toruzou.SalesProjections.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Sales Projection"
    options.model or= Toruzou.request "salesProjection:new"
    super options
