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
      dealId:
        editorAttrs:
          placeholder: "Deal"
      organizationId:
        editorAttrs:
          placeholder: "Organization"
      note:
        editorAttrs:
          placeholder: "Note"
      # TODO deals, people, users

    constructor: (options) ->
      super options
      @title = _.result options, "title"

    serializeData: ->
      data = super
      data["title"] = @title
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
