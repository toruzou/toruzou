Show = Toruzou.module "Activities.Show"

class Show.View extends Marionette.Layout

  template: "activities/show"
  regions:
    updatesRegion: "#updates [data-section-content]"
    filesRegion: "#files [data-section-content]"
  events:
    "click #delete-button": "delete"
    "click #restore-button": "restore"
    "click [data-section-title]": "sectionChanged"

  sectionChanged: (e) ->
    $section = $(e.target).closest("section")
    @show $section.attr "id"

  show: (slug) ->
    return unless slug
    @switchActive slug
    switch slug
      when "updates"
        @showUpdates()
      when "files"
        @showFiles()

  switchActive: (slug) ->
    _.each @$el.find("section"), (section) -> $(section).removeClass "active"
    @$el.find("##{slug}").addClass "active"
    Toruzou.execute "navigate:activities:show", @model.get("id"), slug

  showUpdates: ->
    $.when(Toruzou.request "changelogs:fetch", activity_id: @model.get "id").done (changelogs) =>
      @updatesRegion.show new Toruzou.Changelogs.Index.ListView collection: changelogs, model: @model

  showFiles: ->
    view = new Toruzou.Attachments.View
      fetch: activity_id: @model.get "id"
      dropzone: url: _.result @model, "attachmentsUrl"
    @filesRegion.show view

  onRender: ->
    @$el.foundation("section", "reflow")

  delete: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.destroy().done -> Toruzou.execute "show:activities:list"
    
  restore: (e) ->
    e.preventDefault()
    e.stopPropagation()
    options = url: _.result(@model, "url") + "?restore=true"
    @model.save(@model.attributes, options).done (model) ->
      Toruzou.execute "show:activities:show", model.get "id"
