Toruzou.module "Organizations.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

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
          @trigger "organizations:saved"
          
    cancel: (e) ->
      e.preventDefault()
      @close()
