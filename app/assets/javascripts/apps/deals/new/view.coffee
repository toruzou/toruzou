New = Toruzou.module "Deals.New"

class New.View extends Toruzou.Deals.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Deal"
    options.model or= new Toruzou.Models.Deal()
    super options
