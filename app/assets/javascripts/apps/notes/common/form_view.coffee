Toruzou.module "Note.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

    template: "notes/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      message:
        editorAttrs:
          placeholder: "Add a note"

    constructor: (options = {}) ->
      options.model or= new Toruzou.Models.Note()
      super options

    onShow: ->
      @$el.find("textarea").focus()

    save: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) =>
          Common.trigger "note:saved", model
          @trigger "editor:commit", model
          
    cancel: (e) ->
      e.preventDefault()
      @trigger "editor:cancel"
