Show = Toruzou.module "Deals.Show"

class Show.View extends Marionette.Layout

  template: "deals/show"
  regions:
    updatesRegion: "#updates [data-section-content]"
    activitiesPanelRegion: ".activities-panel"
    activitiesRegion: "#activities [data-section-content]"
    filesRegion: "#files [data-section-content]"
  events:
    "click #edit-button": "edit"
    "click #delete-button": "delete"
    "click #restore-button": "restore"
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
    @switchActive slug
    Toruzou.execute "navigate:deals:showContents", @model.get("id"), slug
    switch slug
      when "updates"
        @showUpdates()
      when "activities"
        @showActivities()
      when "files"
        @showFiles()

  switchActive: (slug) ->
    _.each @$el.find("section"), (section) -> $(section).removeClass "active"
    @$el.find("##{slug}").addClass "active"

  showUpdates: ->
    $.when(Toruzou.request "updates:fetch", deal_id: @model.get "id").done (updates) =>
      @updatesRegion.show new Toruzou.Updates.Index.ListView collection: updates, model: @model

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
    @model.destroy success: (model, response) -> Toruzou.execute "show:deals:list"
    
  restore: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.save @model.attributes,
      url: _.result(@model, "url") + "?restore=true"
      success: (model, response) -> Toruzou.execute "show:deals:list"

  refresh: (model) ->
    slug = @$el.find("section.active").attr "id"
    @model = model
    @render()
    @show slug
    @showActivitiesPanel()

  showActivitiesPanel: ->
    @activitiesPanelRegion.show new Toruzou.Activities.Panel.View model: @model

  close: ->
    return if @isClosed
    super
    Toruzou.Activities.off "activity:saved activity:deleted", @activitiesHandler
