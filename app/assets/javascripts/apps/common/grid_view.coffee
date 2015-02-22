Common = Toruzou.module "Common"

class Common.GridView extends Marionette.ItemView

  className: "backgrid-container"

  constructor: (options) ->
    super options
    @grid = new Backgrid.Grid
      columns: @columns
      collection: @collection
    @paginator = new Backgrid.Extension.Paginator
      collection: @collection
    @collection.on "backgrid:refresh", @onRefresh, @

  render: ->
    @isClosed = false
    @triggerMethod "before:render", @
    @$el.html @grid.render().$el
    @$el.append @paginator.render().$el
    @bindUIElements()
    @triggerMethod "render", @
    @

  onShow: ->
    @adjustScrollbar()

  onRefresh: ->
    @updateRowAttributes()
    @adjustScrollbar "update"

  updateRowAttributes: ->
    _.each @grid.body.rows, (row) -> row.$el.addClass "deleted" if row.model and row.model.get("deletedAt")

  adjustScrollbar: (options) ->
    @$el.perfectScrollbar options

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

  modelInUTC: true
  displayInUTC: false
  displayFormat: Toruzou.Common.Formatters.LOCAL_DATE_FORMAT

class Backgrid.Extension.LocalDatetimeCell extends Backgrid.Extension.MomentCell

  className: "local-datetime-cell"

  modelInUTC: true
  displayInUTC: false
  displayFormat: Toruzou.Common.Formatters.LOCAL_DATETIME_FORMAT

class Backgrid.Extension.LinkCell extends Backgrid.Cell

  className: "link-cell"
  target: undefined

  render: ->
    @$el.empty()
    rawValue = @model.get(@column.get "name")
    if _.isArray rawValue
      _.each rawValue, (v) => @$el.append @renderLink v
    else
      @$el.append (@renderLink rawValue)
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
    $link

  href: (rawValue) ->
    undefined

  title: (rawValue, formattedValue) ->
    formattedValue

class Backgrid.Extension.IconButtonCell extends Backgrid.Cell

  className: "button-cell"

  render: ->
    $button = @renderIconButton @iconName, @title
    @$el.append $button
    @

  renderIconButton: (iconName, title) ->
    $("<a></a>").attr("href", "/#").attr("tabIndex", -1).attr("title",  title).html "<i class=\"icon-#{iconName} icon-large\"></i>"

