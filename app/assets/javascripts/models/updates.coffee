Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Update = class Update extends Backbone.Model

    urlRoot: Models.endpoint "updates"
    modelName: "update"


  Models.Updates = class Updates extends Backbone.PageableCollection

    url: Models.endpoint "updates"
    model: Models.Update
    mode: "infinite"

    state:
      sortKey: "updated_at"
      order: 1


  API =
    getUpdates: (options) ->
      updates = new Models.Updates()
      _.extend updates.queryParams, options
      dfd = $.Deferred()
      updates.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getUpdate: (id) ->
      update = new Models.Update id: id
      dfd = $.Deferred()
      update.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "updates:fetch", (options) -> API.getUpdates options
  Toruzou.reqres.setHandler "update:fetch", (id) -> API.getUpdate id
  