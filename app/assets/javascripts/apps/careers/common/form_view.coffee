Common = Toruzou.module "Careers.Common"

class Common.FormView extends Toruzou.Common.FormView

  template: "careers/form"
  events:
    "submit form": "save"
    "click .cancel": "cancel"
  schema:
    fromDate:
      editorAttrs:
        placeholder: "From"
    toDate:
      editorAttrs:
        placeholder: "To"
    department:
      editorAttrs:
        placeholder: "Department"
    title:
      editorAttrs:
        placeholder: "Title"
    remarks:
      editorAttrs:
        placeholder: "Remarks"

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
        @triggerMethod "career:saved"
        @triggerMethod "form:closed"
        
  cancel: (e) ->
    e.preventDefault()
    @close()
    @triggerMethod "form:closed"


class Common.EditFormView extends Marionette.Layout

  template: "careers/show"
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
    Toruzou.trigger "career:sectionChanged", id: @model.get("id"), slug: slug

  showForm: ->
    formView = new Common.FormView(_.omit @options, "title")
    formView.on "form:closed", => @close()
    @formRegion.show formView

  showFiles: ->
    view = new Toruzou.Attachments.View
      fetch: career_id: @model.get "id"
      dropzone: url: _.result @model, "attachmentsUrl"
    @filesRegion.show view

  onShow: ->
    @show "form"
