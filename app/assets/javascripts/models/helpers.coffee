Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  class Property

    constructor: (@o, propertyName) ->
      keys = _.str.words propertyName, "."
      index = keys.length - 1
      @propertyName = keys[index]
      (@o = o[keys[i]]) for i in [0..index-1] by 1

    get: ->
      @o[@propertyName]

    set: (value) ->
      @o[@propertyName] = value

    delete: ->
      delete @o[@propertyName]


  Models.endpoint = (url) -> "api/#{Toruzou.Configuration.api.version}/#{url}"

  Models.renameProperty = (o, propertyName, newPropertyName) ->
    property = new Property o, propertyName
    newProperty = new Property o, newPropertyName
    newProperty.set property.get()
    property.delete()
    o
