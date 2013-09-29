Toruzou.module "Organizations.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "organizations/show"
    regions:
      updatesRegion: "#updates [data-section-content]"
      activitiesPanelRegion: ".activities-panel"
      activitiesRegion: "#activities [data-section-content]"
      dealsRegion: "#deals [data-section-content]"
      peopleRegion: "#people [data-section-content]"
      filesRegion: "#files [data-section-content]"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
      "click [data-section-title]": "sectionChanged"

    constructor: (options) ->
      super options
      @activitiesHandler = =>
        $.when(Toruzou.request "organization:fetch", @model.get "id").done (organization) =>
          @model = organization
          @showActivitiesPanel()
      Toruzou.Activities.on "activity:saved activity:deleted", @activitiesHandler

    sectionChanged: (e) ->
      $section = $(e.target).closest("section")
      @show $section.attr "id"

    show: (slug) ->
      return unless slug
      _.each @$el.find("section"), (section) -> $(section).removeClass "active"
      @$el.find("##{slug}").addClass "active"
      switch slug
        when "updates"
          @showUpdates()
        when "activities"
          @showActivities()
        when "deals"
          @showDeals()
        when "people"
          @showPeople()
        when "files"
          @showFiles()
      Toruzou.trigger "organization:sectionChanged", id: @model.get("id"), slug: slug

    showUpdates: ->
      $.when(Toruzou.request "updates:fetch", organization_id: @model.get "id").done (updates) =>
        @updatesRegion.show new Toruzou.Updates.Index.ListView collection: updates, model: @model

    showActivities: ->
      $.when(Toruzou.request "activities:fetch", organization_id: @model.get "id").done (activities) =>
        @activitiesRegion.show new Toruzou.Activities.Index.ListView collection: activities, organization: @model

    showDeals: ->
      $.when(Toruzou.request "deals:fetch", organization_id: @model.get "id").done (deals) =>
        @dealsRegion.show new Toruzou.Deals.Index.ListView collection: deals, organization: @model

    showPeople: ->
      $.when(Toruzou.request "people:fetch", organization_id: @model.get "id").done (people) =>
        @peopleRegion.show new Toruzou.People.Index.ListView collection: people, organization: @model

    showFiles: ->
      view = new Toruzou.Attachments.View
        fetch: organization_id: @model.get "id"
        dropzone: url: _.result @model, "attachmentsUrl"
      @filesRegion.show view

    onRender: ->
      @$el.foundation("section", "reflow")

    onShow: ->
      @showActivitiesPanel()

    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      editView = new Toruzou.Organizations.Edit.View model: @model
      editView.on "organization:saved", (model) => @refresh model
      Toruzou.dialogRegion.show editView

    refresh: (model) ->
      slug = @$el.find("section.active").attr "id"
      @model = model
      @render()
      @show slug
      @showActivitiesPanel()

    showActivitiesPanel: ->
      @activitiesPanelRegion.show new Toruzou.Activities.Panel.View model: @model

    delete: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @model.destroy success: (model, response) -> Toruzou.trigger "organizations:list"

    close: ->
      return if @isClosed
      super
      Toruzou.Activities.off "activity:saved activity:deleted", @activitiesHandler
      
