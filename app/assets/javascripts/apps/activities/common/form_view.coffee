Common = Toruzou.module "Activities.Common"

class Common.FormView extends Toruzou.Common.FormView

  template: "activities/form"
  events:
    "submit form": "save"
    "click .cancel": "cancel"
  schema:
    name:
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
        placeholder: "Client Organization"
    peopleIds:
      editorAttrs:
        placeholder: "Client Members"
    usersIds:
      editorAttrs:
        placeholder: "Our Memberes"
    note:
      editorAttrs:
        placeholder: "Note"

  constructor: (options) ->
    super options
    @title = _.result options, "title"

  serializeData: ->
    data = super
    data["title"] = @title if @title
    data

  save: (e) ->
    e.preventDefault()
    @commit().done (model) -> Toruzou.execute "show:activities:show", model.get "id"
