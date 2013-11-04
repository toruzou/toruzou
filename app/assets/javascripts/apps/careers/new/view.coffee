New = Toruzou.module "Careers.New"

class New.View extends Toruzou.Careers.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Career"
    options.model or= new Toruzou.Model.Career()
    super options
