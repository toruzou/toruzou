Edit = Toruzou.module "Activities.Edit"

class Edit.View extends Toruzou.Activities.Common.FormView

  constructor: (options = {}) ->
    _.extend options, title: "Edit Activity"
    super options

  cancel: (e) ->
    window.history.back()
