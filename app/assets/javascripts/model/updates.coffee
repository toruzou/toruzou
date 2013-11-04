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
  getUpdate: (id) ->
    model = new Model.Update id: id
    model.fetch()
  getUpdates: (options) ->
    collection = new Model.Updates()
    _.extend collection.queryParams, options
    collection.fetch()

Toruzou.reqres.setHandler "update:fetch", API.getUpdate
Toruzou.reqres.setHandler "updates:fetch", API.getUpdates
