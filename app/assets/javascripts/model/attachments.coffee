Model = Toruzou.module "Model"

Model.Attachment = class Attachment extends Backbone.Model

  urlRoot: Model.endpoint "attachments"


Model.Attachments = class Attachments extends Backbone.PageableCollection

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
