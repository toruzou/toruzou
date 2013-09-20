Toruzou.module "People.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.Layout

    template: "people/show"
    regions:
      careersRegion: "#careers [data-section-content]"
      filesRegion: "#files [data-section-content]"
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
        when "careers"
          @showCareers()
        when "files"
          @showFiles()
      Toruzou.trigger "person:sectionChanged", id: @model.get("id"), slug: slug

    showCareers: ->
      $.when(Toruzou.request "careers:fetch", person_id: @model.get("id")).done (careers) =>
        @careersRegion.show new Toruzou.Careers.Index.ListView collection: careers, person: @model

    showFiles: ->
      view = new Toruzou.Attachments.View
        fetch: person_id: @model.get "id"
        dropzone: url: _.result @model, "attachmentsUrl"
      @filesRegion.show view

    onRender: ->
      @$el.foundation("section", "reflow")
      
    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      editView = new Toruzou.People.Edit.View model: @model
      editView.on "people:saved", => @render()
      Toruzou.dialogRegion.show editView

    delete: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @model.destroy success: (model, response) -> Toruzou.trigger "people:list"
