Toruzou.module "Activities.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

    template: "activities/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      subject:
        editorAttrs:
          placeholder: "Subject"
      action:
        editorAttrs:
          placeholder: "Action"
      date:
        editorAttrs:
          placeholder: "Date"
      organizationId:
        editorAttrs:
          placeholder: "Organization"
      note:
        editorAttrs:
          placeholder: "Note"
      # TODO deals, people, users

    serializeData: ->
      data = super
      data["title"] = _.result @options, "title"
      data

    save: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) =>
          @close()
          @triggerMethod "activities:saved"
          
    cancel: (e) ->
      e.preventDefault()
      @close()
