New = Toruzou.module "Organizations.New"

class New.View extends Toruzou.Organizations.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Organization"
    options.model or= new Toruzou.Models.Organization()
    super options
