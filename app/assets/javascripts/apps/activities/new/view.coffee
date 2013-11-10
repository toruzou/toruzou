New = Toruzou.module "Activities.New"

class New.View extends Toruzou.Activities.Common.FormView

  constructor: (options = {}) ->
    options.title or= "New Activity"
    options.model or= Toruzou.request "activity:new"
    console.log options
    super options

  cancel: (e) ->
    window.history.back()
