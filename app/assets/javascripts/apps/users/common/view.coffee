Common = Toruzou.module "Users.Common"

class Common.UserView extends Marionette.Layout

  regions:
    actionsRegion: ".actions-region"
    updatesRegion: "#updates [data-section-content]"
    activitiesPanelRegion: ".activities-panel"
    activitiesRegion: "#activities [data-section-content]"
    organizationRegion: "#organizations [data-section-content]"
    dealsRegion: "#deals [data-section-content]"
    followingsRegion: "#followings [data-section-content]"
  events:
    "click [data-section-title]": "sectionChanged"

  constructor: (options) ->
    super options
    @activitiesHandler = =>
      $.when(Toruzou.request "user:fetch", @model.get "id").done (user) =>
        @model = user
        @showActivitiesPanel()
    Toruzou.Activities.on "activity:saved activity:deleted", @activitiesHandler

  refresh: (model) ->
    slug = @$el.find("section.active").attr "id"
    @model = model
    @render()
    @show slug
    @onShow()

  sectionChanged: (e) ->
    $section = $(e.target).closest("section")
    @show $section.attr "id"

  show: (slug) ->
    return unless slug
    @switchActive slug
    switch slug
      when "updates"
        @showUpdates()
      when "activities"
        @showActivities()
      when "organizations"
        @showOrganizations()
      when "deals"
        @showDeals()
      when "followings"
        @showFollowings()

  switchActive: (slug) ->
    _.each @$el.find("section"), (section) -> $(section).removeClass "active"
    @$el.find("##{slug}").addClass "active"
    @navigateToSlug slug

  navigateToSlug: (slug) ->
    Toruzou.execute "navigate:users:show", @model.get("id"), slug

  showUpdates: ->
    $.when(Toruzou.request "changelogs:fetch", user_id: @model.get "id").done (changelogs) =>
      @updatesRegion.show new Toruzou.Changelogs.Index.ListView collection: changelogs, model: @model

  showActivities: ->
    $.when(Toruzou.request "activities:fetch", users_ids: [@model.get "id"]).done (activities) =>
      @activitiesRegion.show new Toruzou.Activities.Index.ListView collection: activities, users: [ @model ]

  showOrganizations: ->
    $.when(Toruzou.request "organizations:fetch", owner_id: @model.get("id")).done (organizations) =>
      @organizationRegion.show new Toruzou.Organizations.Index.ListView collection: organizations, owner: @model

  showDeals: ->
    $.when(Toruzou.request "deals:fetch", user_id: @model.get "id").done (deals) =>
      @dealsRegion.show new Toruzou.Deals.Index.ListView collection: deals

  showFollowings: ->
    $.when(Toruzou.request "user:followings:fetch", @model.get "id").done (followings) =>
      @followingsRegion.show new Toruzou.Followings.Index.ListView collection: followings

  onRender: ->
    @$el.foundation("section", "reflow")

  onShow: ->
    @showActions()
    @showActivitiesPanel()

  showActivitiesPanel: ->
    @activitiesPanelRegion.show new Toruzou.Activities.Panel.View model: @model
    
  close: ->
    return if @isClosed
    super
    Toruzou.Activities.off "activity:saved activity:deleted", @activitiesHandler
   