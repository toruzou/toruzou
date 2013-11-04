New = Toruzou.module "Note.New"

class New.AddNoteView extends Marionette.ItemView

  template: "notes/add"
  events:
    "click .add-note": "activateEditor"

  activateEditor: (e) ->
    e.preventDefault()
    @triggerMethod "editor:activate"

class New.View extends Marionette.Layout

  template: "notes/editor"
  regions:
    editorRegion: ".editor-container"

  constructor: (options) ->
    super options
    _.bindAll @, "activateEditor", "deactivateEditor"

  onShow: ->
    @deactivateEditor()

  activateEditor: ->
    view = new Toruzou.Note.Common.FormView model: @model.createNote()
    view.on "editor:commit editor:cancel", @deactivateEditor
    @editorRegion.show view

  deactivateEditor: ->
    view = new New.AddNoteView()
    view.on "editor:activate", @activateEditor
    @editorRegion.show view
    