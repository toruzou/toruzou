Model = Toruzou.module "Model"

class Model.Attachment extends Backbone.Model

  urlRoot: Model.endpoint "attachments"


class Model.Attachments extends Backbone.PageableCollection

  url: Model.endpoint "attachments"
  model: Model.Attachment

  state:
    sortKey: "updated_at"
    order: 1


API =
  getAttachments: (options) ->
    collection = new Model.Attachments()
    _.extend collection.queryParams, options
    collection.fetch()

Toruzou.reqres.setHandler "attachments:fetch", API.getAttachments
Toruzou.reqres.setHandler "linkTo:attachment:download", (name, id) ->
  model = new Model.Attachment id: id
  "<a href=\"#{_.result model, "url"}\" data-bypass>#{name}</a>"
