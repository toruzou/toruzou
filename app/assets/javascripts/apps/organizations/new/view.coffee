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
      @commit
        success: (model, response) =>
          @close()
          Toruzou.trigger "organizations:saved"

    cancel: (e) ->
      e.preventDefault()
      @close()
