Toruzou.addInitializer ->

  # for Rails JSON Format
  # You should use ```serialize``` for client side implementation.
  # ```toJSON``` is used to communicate with server side API.
  toJSON = Backbone.Model::toJSON
  Backbone.Model::serialize = toJSON
  Backbone.Model::toJSON = ->
    attributes = {}
    (attributes[_.str.underscored(key)] = value) for key, value of @serialize()
    return attributes unless @modelName
    data = {}
    data[@modelName] = attributes
    data
  Backbone.Model::parse = (resp, options) ->
    return resp unless resp
    attributes = {}
    (attributes[_.str.camelize(key)] = value) for key, value of resp
    attributes

  # TODO Should implement parse method for adapting naming convention.

  # for Rails CSRF Token
  sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    if _.include [ "create", "update", "patch", "delete" ], method
      options.beforeSend = _.wrap options.beforeSend, (beforeSend, xhr) ->
        unless options.noCSRF
          token = $("meta[name=\"csrf-token\"]").attr("content")
          xhr.setRequestHeader "X-CSRF-Token", token if token
        beforeSend @, xhr if beforeSend
    sync method, model, options