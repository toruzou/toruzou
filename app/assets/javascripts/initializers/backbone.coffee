Toruzou.addInitializer ->

  # for Rails JSON Format
  toJSON = Backbone.Model::toJSON
  Backbone.Model::toJSON = ->
    attributes = {}
    (attributes[_.str.underscored(key)] = value) for key, value of (toJSON.call @)
    return attributes unless @modelName
    data = {}
    data[@modelName] = attributes
    data

  # TODO Should implement parse method for adapting naming convention.

  # for Rails CSRF Token
  sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    if method is "create" or method is "update" or method is "patch"
      options.beforeSend = _.wrap options.beforeSend, (beforeSend, xhr) ->
        unless options.noCSRF
          token = $("meta[name=\"csrf-token\"]").attr("content")
          xhr.setRequestHeader "X-CSRF-Token", token if token
        beforeSend @, xhr if beforeSend
    sync method, model, options