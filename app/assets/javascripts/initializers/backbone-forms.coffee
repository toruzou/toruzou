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
    setError.call @, "<i class=\"icon-warning-sign\"></i> #{message}"