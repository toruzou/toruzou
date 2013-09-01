Toruzou.addInitializer ->

  Backbone.Marionette.Renderer.render = (template, data) -> JST[template](data)

  Backbone.Marionette.View::serializeData = ->
    context = @model or= {}
    context = if context.serialize then context.serialize() else context
    context

  Backbone.Marionette.ItemView::serializeData = Backbone.Marionette.View::serializeData
  