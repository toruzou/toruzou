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

  # workaround for restoring selected or not.
  Backgrid.Extension.SelectRowCell::render = ->
    selected = @model.get(@column.get "name")
    @$el.empty().append "<input tabindex='-1' type='checkbox' #{if selected then 'checked' else ''}/>"
    @delegateEvents()
    @

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
      if _.isArray rawValue
        _.each rawValue, (v) => @renderLink v
      else
        @renderLink rawValue
      @delegateEvents()
      @

    renderLink: (rawValue) ->
      formattedValue = @formatter.fromRaw rawValue
      href = @href rawValue
      if _.isUndefined href or _.isNull href
        $link = $("<span></span>")
      else
        $link = $("<a></a>").attr("href", href)
      $link
        .attr("tabIndex", -1)
        .attr("title", @title rawValue, formattedValue)
      $link.attr "target", @target if @target
      $link.text formattedValue
      @$el.append $link

    href: (rawValue) ->
      undefined

    title: (rawValue, formattedValue) ->
      formattedValue


