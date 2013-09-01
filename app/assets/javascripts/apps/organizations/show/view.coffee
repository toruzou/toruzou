Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.ItemView

    template: "organizations/show"
    events:
      "click #edit-organization-button": "edit"

    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      # editingModel = $.extend true, @model
      # editingModel.set "owner", editingModel.get("owner")?.id
      # console.log editingModel.attributes
      editView = new Toruzou.Organizations.Edit.View model: @model
      editView.on "organizations:saved", => @render()
      Toruzou.dialogRegion.show editView
