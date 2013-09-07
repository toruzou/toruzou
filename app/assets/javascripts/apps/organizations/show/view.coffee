Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "organizations/show"
    regions:
      peopleRegion: "#people [data-section-content]"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
      "click [data-section-title]": "sectionChanged"

    sectionChanged: (e) ->
      $section = $(e.target).closest("section")
      @show $section.attr "id"

    show: (slug) ->
      return unless slug
      _.each @$el.find("section"), (section) -> $(section).removeClass "active"
      @$el.find("##{slug}").addClass "active"
      switch slug
        when "people"
          @showPeople()
      Toruzou.trigger "organization:sectionChanged", id: @model.get("id"), slug: slug

    showPeople: ->
      # TODO should fetch from organization resource (/organizations/people)
      $.when(Toruzou.request "people:fetch", organization_id: @model.get "id").done (people) =>
        @peopleRegion.show new Toruzou.People.Index.ListView collection: people, organization: @model

    onRender: ->
      @$el.foundation("section", "reflow")

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
