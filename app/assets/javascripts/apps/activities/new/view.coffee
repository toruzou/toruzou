New = Toruzou.module "Activities.New"

class New.View extends Toruzou.Activities.Common.FormView

  constructor: (options = {}) ->
    options.title or= "New Activity"
    options.model or= Toruzou.request "activity:new"
    super options

  cancel: (e) ->
    window.history.back()
