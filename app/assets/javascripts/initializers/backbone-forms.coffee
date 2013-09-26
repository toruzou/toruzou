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

  class NumberEditor extends Backbone.Form.editors.Text

    defaultValue: null
    formatEnabled: true
    commaFormatEnabled: false
    percentFormatEnabled: false
    decimalAllowed: true
    negativeAllowed: true

    initialize: (options) ->
      super options
      _.bindAll @, "onFocus", "onBlur", "onKeyUp", "onKeyPress"
      @on "focus", @onFocus
      @on "blur", @onBlur
      @$el.on "keyup", @onKeyUp
      @$el.on "keypress", @onKeyPress
      @$el.on "change", @onFocus

    onKeyPress: (e) ->

      if e.charCode is 0
        delayed => @determineChange()
        return

      v = String.fromCharCode e.charCode
      switch v
        when "."
          e.preventDefault() if (not @decimalAllowed) or _.str.include @$el.val(), "."
        when "-"
          unless @negativeAllowed
            e.preventDefault()
            return
          caret = $(e.target).selection("getPos")
          value = @$el.val()
          e.preventDefault() if (_.str.startsWith value, "-") or caret.start isnt 0 or caret.end isnt 0
        when "T", "M", "B", "t", "m", "b"
          value = @$el.val()
          e.preventDefault() if (_.isNull value) or value is "" or (_.str.include value, ".")
        when "0"
          caret = $(e.target).selection("getPos")
          value = @$el.val()
          pos = if _.str.startsWith value, "-" then 1 else 0
          e.preventDefault() if caret.start is pos or caret.end is pos
        else
          e.preventDefault() unless /\d|\.$/.test v

    onKeyUp: (e) ->

      originalValue = @$el.val()
      value = originalValue
      value = value.replace /T/gi, "000"
      value = value.replace /M/gi, "000000"
      value = value.replace /B/gi, "000000000"

      if @isValid value
        if value isnt originalValue
          @$el.val value
          @$el.selection "setPos", start: value.length, end: value.length
        delayed @determineChange()

    isValid: (value) ->
      /^-?\d*\.?\d*?$/.test value.toString()

    onBlur: ->
      @$el.val @formatValue @$el.val()

    onFocus: ->
      value = @unformatValue @$el.val()
      @$el.val if _.isNull value then "" else value.toString()
      @$el.val "" unless @isValid @$el.val()

    formatValue: (value) ->
      if @formatEnabled
        return "" if @negativeAllowed and value is "-"
        values = value.toString().split "."
        integral = values[0]
        integral = integral.replace /\B(?=(\d{3})+(?!\d))/g, "," if @commaFormatEnabled
        decimal = if values[1] then ".#{values[1]}" else ""
        formatted = integral + decimal
        return formatted + " %" if @percentFormatEnabled and formatted.length > 0
        formatted
      else
        value

    unformatValue: (formattedValue) ->
      return null if (_.isNull formattedValue) or (formattedValue is "")
      if @formatEnabled
        formattedValue = formattedValue.trim()
        formattedValue = formattedValue.split(",").join("")
        formattedValue.split("%").join("").trim()
      else
        formattedValue

    getValue: ->
      @unformatValue @$el.val()

  Backbone.Form.editors.Integer = class extends NumberEditor

    decimalAllowed: false
    negativeAllowed: true

  Backbone.Form.editors.PositiveInteger = class extends Backbone.Form.editors.Integer

    decimalAllowed: false
    negativeAllowed: false

  Backbone.Form.editors.PercentInteger = class extends Backbone.Form.editors.Integer

    percentFormatEnabled: true

  Backbone.Form.editors.PositivePercentInteger = class extends Backbone.Form.editors.PositiveInteger

    percentFormatEnabled: true

  Backbone.Form.editors.Float = class extends NumberEditor

    decimalAllowed: true
    negativeAllowed: true
    commaFormatEnabled: false

  Backbone.Form.editors.PositiveFloat = class extends Backbone.Form.editors.Float

    decimalAllowed: true
    negativeAllowed: false
    commaFormatEnabled: false

  Backbone.Form.editors.PercentFloat = class extends Backbone.Form.editors.Float

    percentFormatEnabled: true

  Backbone.Form.editors.PositivePercentFloat = class extends Backbone.Form.editors.PositiveFloat

    percentFormatEnabled: true

  Backbone.Form.editors.Amount = class extends Backbone.Form.editors.Integer

    commaFormatEnabled: true

  Backbone.Form.editors.PositiveAmount = class extends Backbone.Form.editors.PositiveInteger

    commaFormatEnabled: true

  Backbone.Form.editors.Selectize = class SelectizeEditor extends Backbone.Form.editors.Select

    initialize: (options) ->
      options.schema.options = @initializeOptions options.schema.options
      super options

    initializeOptions: (options) ->
      _.map options or= [], (option) ->
        if _.isString option
          { val: option, label: option }
        else if _.isObject option
          option.val = option.label if _.isUndefined option.val
          option

    render: ->
      super
      delayed =>
        @$el.selectize @buildOptions();
        @$selectize = @$el[0].selectize
        @clearSelection()
        @restoreSelection()
      @

    clearSelection: ->
      @setValue null

    restoreSelection: ->
      return unless @schema.restore
      selection = @schema.restore @model
      @$selectize.addOption selection.data if selection and selection.data
      @setValue selection.value if selection and selection.value
        
    buildOptions: ->
      @schema.selectize

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
        _.extend pickadateOptions, @schema.pickadate if @schema.pickadate
        @$el.pickadate pickadateOptions
      @

  Backbone.Form.editors.TextArea = class FSTextAreaEditor extends Backbone.Form.editors.TextArea

    render: ->
      super
      delayed =>
        @$el.fseditor()
        $div = @$el.parent()
        @$editor = $div.find "[contenteditable]"
        @$editor.html @value
        $div.find("a.fs-icon").attr("data-bypass", "")
      @

    setValue: (value) ->
      @$editor?.html value

    getValue: ->
      @$editor?.html()

    remove: ->
      @$el.fseditor("destroy")
      super
