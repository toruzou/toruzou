Edit = Toruzou.module "Activities.Edit"

class Edit.View extends Toruzou.Activities.Common.EditFormView

  constructor: (options) ->
    options = _.extend options or= {}, title: "Edit Activity"
    super options
