Toruzou.module "Users.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "users/show"
    regions:
      activitiesRegion: "#activities [data-section-content]"
      organizationRegion: "#organizations [data-section-content]"
      dealsRegion: "#deals [data-section-content]"
      filesRegion: "#files [data-section-content]"
    events:
      "click [data-section-title]": "sectionChanged"

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
        when "organizations"
          @showOrganizations()
        when "deals"
          @showDeals()
      Toruzou.trigger "user:sectionChanged", id: @model.get("id"), slug: slug

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
      