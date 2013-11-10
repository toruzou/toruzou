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
    @headerTitle = _.result options, "headerTitle"
    @dialog = options.dialog

  serializeData: ->
    data = super
    data["headerTitle"] = @headerTitle if @headerTitle
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
    data["headerTitle"] = @options.headerTitle
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

  showForm: ->
    formView = new Common.FormView(_.omit @options, "headerTitle")
    formView.on "form:closed", => @close()
    @formRegion.show formView

  showFiles: ->
    view = new Toruzou.Attachments.View
      fetch: career_id: @model.get "id"
      dropzone: url: _.result @model, "attachmentsUrl"
    @filesRegion.show view

  onShow: ->
    @show "form"
