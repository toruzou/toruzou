Toruzou.addInitializer ->

  Backbone.Marionette.View::mixinTemplateHelpers = (target = {}) ->
    helpers = Marionette.getOption @, "templateHelpers"
    helpers = helpers.call @ if helpers and _.isFunction helpers
    _.extend target.templateHelpers or= {}, helpers if helpers
    target

  Backbone.Marionette.View::serializeData = ->
    context = @model or= {}
    context = if context.serialize then context.serialize() else context
    context

  Backbone.Marionette.ItemView::serializeData = Backbone.Marionette.View::serializeData
  
  Backbone.Marionette.Renderer.render = (template, data) ->
    helpers = Handlebars.helpers
    helpers = _.extend {}, Handlebars.helpers, data.templateHelpers if data and data.templateHelpers
    JST[template] data, helpers: helpers
