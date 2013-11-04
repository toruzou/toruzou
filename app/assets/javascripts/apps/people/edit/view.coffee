Edit = Toruzou.module "People.Edit"

class Edit.View extends Toruzou.People.Common.FormView

  constructor: (options) ->
    options = _.extend options or= {}, title: "Edit Person"
    super options
