Toruzou.module "Organizations.New", (New, Toruzou, Backbone, Marionette, $, _) ->

  class New.View extends Toruzou.Common.FormView

    template: "organizations/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      name:
        editorAttrs:
          placeholder: "Name"
      abbreviation:
        editorAttrs:
          placeholder: "Abbreviation"
      address:
        editorAttrs:
          placeholder: "Address"
      remarks:
        editorAttrs:
          placeholder: "Remarks"
      url:
        editorAttrs:
          placeholder: "Website URL"

    constructor: ->
      super model: new Toruzou.Models.Organization()

    serializeData: ->
      data = super
      data["title"] = "New Organization"
      data

    save: (e) ->
      # TODO Remove code duplication
      e.preventDefault()
      Toruzou.Common.Helpers.Notification.clear @$el
      @commit
        success: (model, response) ->
          @close()
          Toruzou.trigger "organizations:saved"
        error: (model, response) ->
          result = $.parseJSON response.responseText
          options = {}
          options.title = "Failed to save organization"
          options.messages = []
          for property, errors of result.errors
            title = @$el.find("#label-#{property}")?.text() or _.str.capitalize property
            for error in errors
              options.messages.push "#{title} #{error}"
          @$el.find("form").prepend Toruzou.Common.Helpers.Notification.error options

    cancel: (e) ->
      e.preventDefault()
      @close()
