New = Toruzou.module "Careers.New"

class New.View extends Toruzou.Careers.Common.FormView

  constructor: (options) ->
    options or= {}
    options.headerTitle or= "New Career"
    options.model or= Toruzou.request "career:new"
    super options
