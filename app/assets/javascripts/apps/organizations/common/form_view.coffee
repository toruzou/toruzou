Common = Toruzou.module "Organizations.Common"

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
        @trigger "organization:saved", model
        
  cancel: (e) ->
    e.preventDefault()
    @close()
