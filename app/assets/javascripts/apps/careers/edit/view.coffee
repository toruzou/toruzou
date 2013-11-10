Edit = Toruzou.module "Careers.Edit"

class Edit.View extends Toruzou.Careers.Common.EditFormView

  constructor: (options = {}) ->
    _.extend options or= {}, headerTitle: "Edit Career"
    super options
