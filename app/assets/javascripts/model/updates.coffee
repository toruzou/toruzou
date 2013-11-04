Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Update = class Update extends Backbone.Model

  urlRoot: Model.endpoint "updates"
  modelName: "update"


Model.Updates = class Updates extends Backbone.PageableCollection

  url: Model.endpoint "updates"
  model: Model.Update
  mode: "infinite"

  state:
    sortKey: "updated_at"
    order: 1


API =
  getUpdates: (options) ->
    updates = new Model.Updates()
    _.extend updates.queryParams, options
    dfd = $.Deferred()
    updates.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getUpdate: (id) ->
    update = new Model.Update id: id
    dfd = $.Deferred()
    update.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "updates:fetch", (options) -> API.getUpdates options
Toruzou.reqres.setHandler "update:fetch", (id) -> API.getUpdate id
