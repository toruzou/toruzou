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

  class Backgrid.Extension.LocalDateCell extends Backgrid.Extension.MomentCell

    className: "local-date-cell"

    formatter: class extends Backgrid.Extension.MomentFormatter
      modelInUtc: false
      modelFormat: "YYYY-MM-DD"
      displayInUtc: false
      displayFormat: "YYYY/MM/DD"
      fromRaw: (rawData) ->
        super if _.str.isBlank(rawData) then null else rawData # workaround

  class Backgrid.Extension.LinkCell extends Backgrid.Cell

    className: "link-cell"
    target: undefined

    render: ->
      @$el.empty()
      rawValue = @model.get(@column.get "name")
      formattedValue = @formatter.fromRaw rawValue
      $link = $("<a></a>")
        .attr("tabIndex", -1)
        .attr("href", _.result(@, "href") or "/#")
        .attr("title", if @title then (_.result @, "title") else formattedValue)
      $link.attr "target", @target if @target
      $link.text formattedValue
      @$el.append $link
      @delegateEvents()
      @

