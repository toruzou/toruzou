Toruzou.module "Activities.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

    template: "activities/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      subject:
        editorAttrs:
          placeholder: "Subject"
      action:
        editorAttrs:
          placeholder: "Action"
      date:
        editorAttrs:
          placeholder: "Date"
      dealId:
        editorAttrs:
          placeholder: "Deal"
      organizationId:
        editorAttrs:
          placeholder: "Organization"
      usersIds:
        editorAttrs:
          placeholder: "Users"
      peopleIds:
        editorAttrs:
          placeholder: "Contacts"
      note:
        editorAttrs:
          placeholder: "Note"

    constructor: (options) ->
      super options
      @title = _.result options, "title"
      @dialog = options.dialog

    serializeData: ->
      data = super
      data["title"] = @title if @title
      data

    save: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) =>
          @close()
          @triggerMethod "activities:saved"
          @triggerMethod "form:closed"
          
    cancel: (e) ->
      e.preventDefault()
      @triggerMethod "form:closed"
      @close()


  class Common.EditFormView extends Marionette.Layout

    template: "activities/show"
    regions:
      formRegion: "#form [data-section-content]"
      filesRegion: "#files [data-section-content]"
    events:
      "click [data-section-title]": "sectionChanged"

    constructor: (options) ->
      super options
      @options = options

    serializeData: ->
      data = super
      data["title"] = @options.title
      data
      
    sectionChanged: (e) ->
      $section = $(e.target).closest("section")
      @show $section.attr "id"

    show: (slug) ->
      return unless slug
      _.each @$el.find("section"), (section) -> $(section).removeClass "active"
      @$el.find("##{slug}").addClass "active"
      switch slug
        when "form"
          @showForm()
        when "files"
          @showFiles()
      Toruzou.trigger "activity:sectionChanged", id: @model.get("id"), slug: slug

    showForm: ->
      formView = new Common.FormView(_.omit @options, "title")
      formView.on "form:closed", => @close()
      @formRegion.show formView

    showFiles: ->
      view = new Toruzou.Attachments.View
        fetch: activity_id: @model.get "id"
        dropzone: url: _.result @model, "attachmentsUrl"
      @filesRegion.show view

    onShow: ->
      @show "form"
