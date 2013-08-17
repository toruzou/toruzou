Toruzou.addInitializer ->

  Backbone.Marionette.Renderer.render = (template, data) -> JST[template](data)

  Backbone.Marionette.View::serializeData = ->
    context = @model or= {}
    context = if context.toJSON then context.toJSON() else context
    context