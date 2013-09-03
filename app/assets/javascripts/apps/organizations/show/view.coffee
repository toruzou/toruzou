Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "organizations/show"
    regions:
      peopleRegion: "#people-region"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
      "click #people-region-header": "showPeople"

    showPeople: ->
      $.when(Toruzou.request "people:fetch", organization_id: @model.id).done (people) =>
        @peopleRegion.show new Toruzou.People.Index.ListView collection: people

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
