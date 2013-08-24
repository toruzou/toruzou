Toruzou.addInitializer ->

  # for Rails JSON Format
  toJSON = Backbone.Model::toJSON
  Backbone.Model::toJSON = ->
    attributes = toJSON.call @
    return attributes unless @modelName
    data = {}
    data[@modelName] = attributes
    data

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