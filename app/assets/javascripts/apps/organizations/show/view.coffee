Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.ItemView

    template: "organizations/show"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
    onRender: ->
      @$el.foundation("section", "reflow");

    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      editView = new Toruzou.Organizations.Edit.View model: @model
      editView.on "organizations:saved", => @render()
      Toruzou.dialogRegion.show editView

    delete: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @model.destroy success: (model, response) -> Toruzou.trigger "organizations:list"
