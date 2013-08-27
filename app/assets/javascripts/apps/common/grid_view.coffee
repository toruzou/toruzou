Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.GridView extends Marionette.ItemView

    className: "backgrid-container"

    constructor: (options) ->
      super options
      @grid = new Backgrid.Grid
        columns: @columns
        collection: @collection
      @paginator = new Backgrid.Extension.Paginator
        collection: @collection

    render: ->
      @isClosed = false
      @triggerMethod "before:render", @
      @$el.html @grid.render().$el
      @$el.append @paginator.render().$el
      @bindUIElements()
      @triggerMethod "render", @
      @

    close: ->
      return if @isClosed
      @grid.remove()
      delete @grid
      @paginator.remove()
      delete @paginator
      super
