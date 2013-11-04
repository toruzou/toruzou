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
    attachments = new Model.Attachments()
    _.extend attachments.queryParams, options
    dfd = $.Deferred()
    attachments.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()

Toruzou.reqres.setHandler "attachments:fetch", (options) -> API.getAttachments options
