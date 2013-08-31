Toruzou.addInitializer ->

  wrapEditor = (Editor) ->

    class FeedbackEditor extends Editor

      initialize: (options) ->
        super options
        @on "blur", => @form.fields[@key].validate()

  _.map Backbone.Form.editors, (Editor, key) -> Backbone.Form.editors[key] = wrapEditor Editor

  Backbone.Form.Field.template = JST["common/form/field"]

  setError = Backbone.Form.Field::setError
  Backbone.Form.Field::setError = (message) ->
    setError.call @, "<i class=\"icon-warning-sign icon-inline-prefix\"></i>#{message}"

  delayed = (fn) -> setTimeout fn, 0
  Backbone.Form.editors.Selectize = class SelectizeEditor extends Backbone.Form.editors.Select

    initialize: (options) ->
      options.schema.options or= []
      super options

    render: ->
      super
      delayed => @$el.selectize @buildOptions()
      @

    buildOptions: ->
      selectizeOptions = @options.schema.selectize
      onChange = selectizeOptions.onChange
      selectizeOptions.onChange = (value) =>
        onChange value if onChange
        @onValueChanged value
      selectizeOptions

    onValueChanged: (value) ->
      @setValue value

    setValue: (value) ->
      @value = value

    getValue: ->
      @value
