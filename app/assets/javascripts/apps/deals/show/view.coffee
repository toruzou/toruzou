Toruzou.module "Deals.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "deals/show"
    regions:
      activitiesPanelRegion: ".activities-panel"
      activitiesRegion: "#activities [data-section-content]"
      filesRegion: "#files [data-section-content]"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
      "click [data-section-title]": "sectionChanged"

    constructor: (options) ->
      super options
      @activitiesHandler = =>
        $.when(Toruzou.request "deal:fetch", @model.get "id").done (deal) =>
          @model = deal
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
        when "activities"
          @showActivities()
        when "files"
          @showFiles()
      Toruzou.trigger "deal:sectionChanged", id: @model.get("id"), slug: slug

    showActivities: ->
      $.when(Toruzou.request "activities:fetch", deal_id: @model.get "id").done (activities) =>
        @activitiesRegion.show new Toruzou.Activities.Index.ListView collection: activities, deal: @model

    showFiles: ->
      view = new Toruzou.Attachments.View
        fetch: deal_id: @model.get "id"
        dropzone: url: _.result @model, "attachmentsUrl"
      @filesRegion.show view

    onRender: ->
      @$el.foundation("section", "reflow")

    onShow: ->
      @showActivitiesPanel()
      
    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      editView = new Toruzou.Deals.Edit.View model: @model
      editView.on "deal:saved", (model) => @refresh model
      Toruzou.dialogRegion.show editView

    delete: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @model.destroy success: (model, response) -> Toruzou.trigger "deals:list"
      
    refresh: (model) ->
      @model = model
      @render()
      @showActivitiesPanel()

    showActivitiesPanel: ->
      @activitiesPanelRegion.show new Toruzou.Activities.Panel.View model: @model

    close: ->
      return if @isClosed
      super
      Toruzou.Activities.off "activity:saved activity:deleted", @activitiesHandler
