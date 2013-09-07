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
      delayed =>
        @$el.selectize @buildOptions();
        @$selectize = @$el[0].selectize
        @restoreSelection()
      @

    restoreSelection: ->
      return unless @schema.restore
      selection = @schema.restore @model
      @$selectize.addOption selection.data if selection and selection.data
      @setValue selection.value if selection and selection.value
        
    buildOptions: ->
      @options.schema.selectize

    setValue: (value) ->
      @$selectize?.setValue value

    getValue: ->
      @$selectize?.getValue()

    remove: ->
      super
      @$selectize?.off()

  Backbone.Form.editors.Datepicker = class SelectizeEditor extends Backbone.Form.editors.Text

    className: "datepicker"
    pickadate:
      format: "yyyy/mm/dd"
      formatSubmit: "yyyy/mm/dd"

    render: ->
      super
      delayed =>
        pickadateOptions = _.extend {}, @pickadate
        _.extend pickadateOptions, @options.pickadate if @options.pickadate
        @$el.pickadate pickadateOptions
      @
