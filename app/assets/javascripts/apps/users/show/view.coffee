Show = Toruzou.module "Users.Show"

class Show.View extends Marionette.Layout

  template: "users/show"
  regions:
    updatesRegion: "#updates [data-section-content]"
    activitiesPanelRegion: ".activities-panel"
    activitiesRegion: "#activities [data-section-content]"
    organizationRegion: "#organizations [data-section-content]"
    dealsRegion: "#deals [data-section-content]"
    filesRegion: "#files [data-section-content]"
  events:
    "click #follow-button": "follow"
    "click #unfollow-button": "unfollow"
    "click [data-section-title]": "sectionChanged"

  constructor: (options) ->
    super options
    @activitiesHandler = =>
      $.when(Toruzou.request "user:fetch", @model.get "id").done (user) =>
        @model = user
        @showActivitiesPanel()
    Toruzou.Activities.on "activity:saved activity:deleted", @activitiesHandler

  follow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("user:follow", @model.get "id").done (model) => @refresh model

  unfollow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("user:unfollow", @model.get "id").done (model) => @refresh model

  refresh: (model) ->
    slug = @$el.find("section.active").attr "id"
    @model = model
    console.log "render", model
    @render()
    @show slug
    @showActivitiesPanel()

  sectionChanged: (e) ->
    $section = $(e.target).closest("section")
    @show $section.attr "id"

  show: (slug) ->
    return unless slug
    @switchActive slug
    Toruzou.execute "navigate:users:show", @model.get("id"), slug
    switch slug
      when "updates"
        @showUpdates()
      when "activities"
        @showActivities()
      when "organizations"
        @showOrganizations()
      when "deals"
        @showDeals()

  switchActive: (slug) ->
    _.each @$el.find("section"), (section) -> $(section).removeClass "active"
    @$el.find("##{slug}").addClass "active"

  showUpdates: ->
    $.when(Toruzou.request "changelogs:fetch", user_id: @model.get "id").done (changelogs) =>
      @updatesRegion.show new Toruzou.Updates.Index.ListView collection: changelogs, model: @model

  showActivities: ->
    $.when(Toruzou.request "activities:fetch", users_ids: [@model.get "id"]).done (activities) =>
      @activitiesRegion.show new Toruzou.Activities.Index.ListView collection: activities, users: [ @model ]

  showOrganizations: ->
    $.when(Toruzou.request "organizations:fetch", owner_id: @model.get("id")).done (organizations) =>
      @organizationRegion.show new Toruzou.Organizations.Index.ListView collection: organizations, owner: @model

  showDeals: ->
    $.when(Toruzou.request "deals:fetch", user_id: @model.get "id").done (deals) =>
      @dealsRegion.show new Toruzou.Deals.Index.ListView collection: deals

  onRender: ->
    @$el.foundation("section", "reflow")

  onShow: ->
    @showActivitiesPanel()

  showActivitiesPanel: ->
    @activitiesPanelRegion.show new Toruzou.Activities.Panel.View model: @model
    
  close: ->
    return if @isClosed
    super
    Toruzou.Activities.off "activity:saved activity:deleted", @activitiesHandler
   