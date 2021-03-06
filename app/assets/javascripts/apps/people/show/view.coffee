Show = Toruzou.module "People.Show"

class Show.View extends Marionette.Layout

  template: "people/show"
  regions:
    updatesRegion: "#updates [data-section-content]"
    activitiesPanelRegion: ".activities-panel"
    activitiesRegion: "#activities [data-section-content]"
    careersRegion: "#careers [data-section-content]"
    dealsRegion: "#deals [data-section-content]"
    filesRegion: "#files [data-section-content]"
  events:
    "click #edit-button": "edit"
    "click #delete-button": "delete"
    "click #restore-button": "restore"
    "click #follow-button": "follow"
    "click #unfollow-button": "unfollow"
    "click [data-section-title]": "sectionChanged"

  constructor: (options) ->
    super options
    @activitiesHandler = =>
      $.when(Toruzou.request "person:fetch", @model.get "id").done (person) =>
        @model = person
        @showActivitiesPanel()
    Toruzou.Activities.on "activity:saved activity:deleted", @activitiesHandler

  follow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("person:follow", @model.get "id").done (model) => @refresh model

  unfollow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("person:unfollow", @model.get "id").done (model) => @refresh model

  sectionChanged: (e) ->
    $section = $(e.target).closest("section")
    @show $section.attr "id"

  show: (slug) ->
    return unless slug
    @switchActive slug
    Toruzou.execute "navigate:people:show", @model.get("id"), slug
    switch slug
      when "updates"
        @showUpdates()
      when "activities"
        @showActivities()
      when "careers"
        @showCareers()
      when "deals"
        @showDeals()
      when "files"
        @showFiles()

  switchActive: (slug) ->
    _.each @$el.find("section"), (section) -> $(section).removeClass "active"
    @$el.find("##{slug}").addClass "active"

  showUpdates: ->
    $.when(Toruzou.request "changelogs:fetch", person_id: @model.get "id").done (changelogs) =>
      @updatesRegion.show new Toruzou.Changelogs.Index.ListView collection: changelogs, model: @model

  showActivities: ->
    $.when(Toruzou.request "activities:fetch", people_ids: [@model.get "id"]).done (activities) =>
      @activitiesRegion.show new Toruzou.Activities.Index.ListView collection: activities, people: [ @model ]

  showCareers: ->
    $.when(Toruzou.request "careers:fetch", person_id: @model.get("id")).done (careers) =>
      @careersRegion.show new Toruzou.Careers.Index.ListView collection: careers, person: @model

  showDeals: ->
    $.when(Toruzou.request "deals:fetch", person_id: @model.get "id").done (deals) =>
      @dealsRegion.show new Toruzou.Deals.Index.ListView collection: deals, person: @model

  showFiles: ->
    view = new Toruzou.Attachments.View
      fetch: person_id: @model.get "id"
      dropzone: url: _.result @model, "attachmentsUrl"
    @filesRegion.show view

  onRender: ->
    @$el.foundation("section", "reflow")

  onShow: ->
    @showActivitiesPanel()
    
  edit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    editView = new Toruzou.People.Edit.View model: @model
    editView.on "person:saved", (model) => @refresh model
    Toruzou.dialogRegion.show editView

  delete: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.destroy success: (model, response) -> Toruzou.execute "show:people:list"

  restore: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.save @model.attributes,
      url: _.result(@model, "url") + "?restore=true"
      success: (model, response) -> Toruzou.execute "show:people:list"

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

