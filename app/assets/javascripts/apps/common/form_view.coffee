Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

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
      serializeData = @serializeData
      constructor = class extends Backbone.Form
        templateData: serializeData
      new constructor options

    commit: (options) ->
      Toruzou.Common.Helpers.Notification.clear @$el
      unless options.error
        options.error = (model, response, options) =>
          @onRequestError response if (response.status + "").match /^4\d{2}$/
      inputs = @$el.find("[type=\"submit\"]:enabled")
      try
        inputs.attr "disabled", "disabled"
        errors = @form.commit()
        if errors
          errors
        else
          attributes = options.attributes or null
          @model.save attributes, options
      finally
        inputs.removeAttr "disabled"

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
      if result and result.errors
        for property, errors of result.errors
          title = @$el.find("#label-#{property}")?.text() or _.str.capitalize property
          for error in errors
            options.messages.push "#{title} #{error}"
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
