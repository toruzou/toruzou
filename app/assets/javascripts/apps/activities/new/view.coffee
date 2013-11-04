New = Toruzou.module "Activities.New"

class New.View extends Toruzou.Activities.Common.FormView

  constructor: (options) ->
    options or= {}
    options.title or= "New Activity"
    options.model or= new Toruzou.Models.Activity()
    super options
