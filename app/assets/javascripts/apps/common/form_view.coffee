Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Marionette.View

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
      for handler in [ "success", "error", "complete" ] then options[handler] = _.bind options[handler], @ if options[handler]
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
