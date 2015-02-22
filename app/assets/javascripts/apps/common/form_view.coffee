Common = Toruzou.module "Common"

class Common.FormView extends Marionette.ItemView

  constructor: (options) ->
    super options
    @form = @initializeForm options
    @form.template = JST[@template] if @template

  initializeForm: (options) ->
    if @schema and options?.model?.schema
      schema = $.extend true, {}, options.model.schema # Clone schema
      schema = $.extend true, schema, @schema # Overwrite schema with view definition
      options.model.schema = schema
    serializeData = _.bind @serializeData, @
    constructor = class extends Backbone.Form
      templateData: serializeData
    new constructor options

  updateModel: ->
    @form.commit()

  commit: (options = {}) ->
    dfd = $.Deferred()
    Toruzou.Common.Helpers.Notification.clear @$el
    submits = @$el.find("[type=\"submit\"]:enabled")
    errors = @form.commit()
    if errors
      dfd.reject errors
    else
      attributes = options.attributes or null
      @model.save(attributes, options)
        .done (model, response, options) ->
          dfd.resolve model, response, options
        .fail (model, response, options) =>
          @onRequestError response if (response.status + "").match /^4\d{2}$/
          dfd.reject model, response, options
    dfd.promise().always -> submits.removeAttr "disabled"

  onRequestError: (response) ->
    result = Toruzou.Common.Helpers.parseJSON response
    if response.status is 422
      @onValidationError result
    else
      @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error { message: result.error }

  onValidationError: (result) ->
    options = {}
    options.title = "Unable to process the request"
    options.messages = []
    addMessage = (property, errors) =>
      title = @model.displayNameOf property
      for error in errors
        options.messages.push "#{title} #{error}"
    if result
      if result.errors
        addMessage property, errors for property, errors of result.errors
      else
        addMessage property, errors for property, errors of result
    @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error options

  render: ->
    @isClosed = false
    @triggerMethod "before:render", @
    @$el.html @form.render().$el
    @bindUIElements()
    @triggerMethod "render", @
    @

  disableForm: (options) ->
    @updateFormState options, true

  enableForm: (options) ->
    @updateFormState options, false

  updateFormState: (options, disabled) ->
    fields = @form.fields
    ignore = if options and options.ignore then options.ignore else []
    field.disabled true for key, field of fields when not (_.include ignore, key)

  close: ->
    return if @isClosed
    @form.remove()
    delete @form
    super


class Common.FilterView extends Common.FormView

  constructor: (options) ->
    super options
    events =
      "click .accordion [data-section-title]": "toggleSection"
      # "click .filter-item": "toggleFilter" # TODO workaround for checkbox, this code is not used for now.
    events = $.extend true, events, @events if @events
    @delegateEvents events

  toggleSection: (e) ->
    $(e.target).closest("section").toggleClass("active")
    false

  toggleFilter: (e) ->
    $element = $(e.target)
    $ul = $element.closest "ul"
    $target = $(e.target).closest("li")
    multipleSelection = _.isUndefined($ul.data "selection-single")
    _.each $ul.find("li.filter-item"), (item) -> $(item).removeClass "active" unless multipleSelection or item is $target[0]
    oldState = $target.hasClass "active"
    $target.toggleClass("active")
    newState = $target.hasClass "active"
    @filterToggled? $target, oldState, newState
    false
