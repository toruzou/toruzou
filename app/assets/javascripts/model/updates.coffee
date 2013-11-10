Model = Toruzou.module "Model"

class Model.Updates extends Backbone.PageableCollection

  mode: "infinite"

  state:
    pageSize: 10
    sortKey: "updated_at"
    order: 1

class Model.Changelog extends Backbone.Model

  urlRoot: Model.endpoint "changelogs"
  modelName: "changelog"

class Model.Changelogs extends Model.Updates

  url: Model.endpoint "changelogs"
  model: Model.Changelog

class Model.Notification extends Backbone.Model

  urlRoot: Model.endpoint "notifications"
  modelName: "notification"

class Model.Notifications extends Model.Updates

  url: Model.endpoint "notifications"
  model: Model.Notification


API =
  getChangelog: (id) ->
    model = new Model.Changelog id: id
    model.fetch()
  getChangelogs: (options) ->
    collection = new Model.Changelogs()
    _.extend collection.queryParams, options
    collection.fetch()
  getNotification: (id) ->
    model = new Model.Notification id: id
    model.fetch()
  getNotifications: (options) ->
    collection = new Model.Notifications()
    _.extend collection.queryParams, options
    collection.fetch()

Toruzou.reqres.setHandler "changelog:fetch", API.getChangelog
Toruzou.reqres.setHandler "changelogs:fetch", API.getChangelogs
Toruzou.reqres.setHandler "notification:fetch", API.getNotification
Toruzou.reqres.setHandler "notifications:fetch", API.getNotifications
