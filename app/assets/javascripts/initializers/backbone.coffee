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

  # monkey patch to resolve response as Backbone.Model when using promise

  setTimeout = (dfd, options) -> _.delay dfd.reject, options.timeout or Toruzou.Configuration.timeout or 5000

  promisify = (subject, method) ->
    fn = subject::[method]
    subject::[method] = (key, val, options) ->
      dfd = $.Deferred()
      opts = key or val or {}
      if method is "save"
        if _.isObject key
          attributes = key
          opts = val or {}
        else if _.isString key
          attributes = {}
          attributes[key] = val
          opts = options or {}
      opts.success = _.wrap opts.success, (success, model, response, opts) ->
        if method is "destroy"
          attributes = model.parse response, opts
          model.set attributes if attributes
        success model, response, opts if success
        dfd.resolve model, response, opts
      opts.error = _.wrap opts.error, (error, model, response, opts) ->
        error model, response, opts if error
        dfd.reject model, response, opts
      setTimeout dfd, opts
      if method is "save"
        fn.call @, attributes or null, opts
      else
        fn.call @, opts
      dfd.promise()

  _.each [
    {
      klass: Backbone.Model
      methods: [ "fetch", "save", "destroy" ]
    }
    {
      klass: Backbone.Collection
      methods: [ "fetch" ]
    }
  ], (subject) -> _.each subject.methods, (method) -> promisify subject.klass, method
