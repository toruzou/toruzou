Toruzou.module "People.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

    template: "people/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      name:
        editorAttrs:
          placeholder: "Name"
      organizationId:
        editorAttrs:
          placeholder: "Organization"
      phone:
        editorAttrs:
          placeholder: "Phone"
      email:
        editorAttrs:
          placeholder: "Email"
      address:
        editorAttrs:
          placeholder: "Address"
      remarks:
        editorAttrs:
          placeholder: "Remarks"
      ownerId:
        editorAttrs:
          placeholder: "Owner"

    serializeData: ->
      data = super
      data["title"] = _.result @options, "title"
      data

    save: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) =>
          @close()
          @triggerMethod "people:saved"
          
    cancel: (e) ->
      e.preventDefault()
      @close()
