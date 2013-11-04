New = Toruzou.module "People.New"

class New.View extends Toruzou.People.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Person"
    options.model or= Toruzou.request "person:new"
    super options
