Common = Toruzou.module "People.Common"

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
        
  constructor: (options) ->
    super options
    @title = _.result options, "title"

  serializeData: ->
    data = super
    data["title"] = @title
    data

  save: (e) ->
    e.preventDefault()
    @commit().done (model) =>
      @close()
      @triggerMethod "person:saved", model
        
  cancel: (e) ->
    e.preventDefault()
    @close()
