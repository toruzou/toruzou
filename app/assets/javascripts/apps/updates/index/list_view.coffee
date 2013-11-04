Index = Toruzou.module "Updates.Index"

# TODO refactoring view, html, css etc ...

class Index.NoteMessageView extends Marionette.ItemView

  template: "updates/note_message"

class Index.NoteItemView extends Marionette.Layout

  template: "updates/note"
  events:
    "click a.edit": "activateEditor"
    "click a.delete": "deleteNote"
  regions:
    contentsRegion: ".contents"

  constructor: (options) ->
    super options
    _.bindAll @, "activateEditor", "deactivateEditor"

  onShow: ->
    @deactivateEditor()

  serializeData: ->
    data = super
    data.subjectRoute = "#{Toruzou.Configuration.routes[data.auditable.subject_type]}:show"
    data.action = Toruzou.Configuration.bundles.actions[data.action]
    data

  activateEditor: (e) ->
    e.preventDefault()
    view = new Toruzou.Note.Common.FormView model: @createNoteModel()
    view.on "editor:commit editor:cancel", @deactivateEditor
    @contentsRegion.show view

  deactivateEditor: ->
    @contentsRegion.show new Index.NoteMessageView model: @model

  deleteNote: (e) ->
    e.preventDefault()
    @createNoteModel().destroy success: => Toruzou.Note.Common.trigger "note:deleted" # TODO

  createNoteModel: ->
    new Toruzou.Models.Note @model.get("auditable")


class Index.ChangeItemView extends Marionette.ItemView

  template: "updates/change"

  # TODO ugly, should refactor
  # TODO Fix link of attachments, career etc
  serializeData: ->
    data = super
    data.audit.action = Toruzou.Configuration.bundles.actions[data.audit.action]
    klazz = Toruzou.Models[data.audit.auditable_type]
    auditable = data.auditable = new klazz data.audit.auditable
    subject = data.updateSubject = if auditable.updateSubject then _.result auditable, "updateSubject" else auditable
    subjectType = data.subjectType = subject.constructor.name.toLowerCase()
    subjectRoute = data.subjectRoute = "#{Toruzou.Configuration.routes[subject.constructor.name]}:show"
    subjectName = data.subjectName = subject.get "name"
    auditableName = data.auditableName = data.audit.auditable_type.toLowerCase() if auditable.updateSubject
    subjectId = data.subjectId = if subject then subject.id else auditable.id
    changes = data.changes = {}
    serializeChange = (key, change) -> Toruzou.Models.format auditable, key, change
    for key, change of data.audit.changes
      key = _.str.camelize key
      changes[key] =
        propertyName: Toruzou.Models.displayPropertyName auditable, key
        before: serializeChange key, change[0]
        after: serializeChange key, change[1]
    data

class Index.UpdateItemView extends Marionette.Layout

  template: "updates/item"
  regions:
    updateRegion: ".update"

  onShow: ->
    audit = new Backbone.Model(@model.get "audit")
    view = undefined
    switch audit.get("auditable_type")
      when "Note"
        view = new Index.NoteItemView model: audit
      when "Activity"
        # TODO
        console.log "TODO: Activity"
      else
        view = new Index.ChangeItemView model: @model
    @updateRegion.show view if view


# FIXME should move endless scrolling handler to common layer
class Index.CollectionView extends Marionette.CollectionView

  itemView: Index.UpdateItemView

  constructor: (options) ->
    throw new Error "The collection is not a pageable-collection." unless options.collection instanceof Backbone.PageableCollection
    super options
    _.bindAll @, "scrollHandler"
    $(window).on "scroll", @scrollHandler

  # Override to listen fullCollection
  _initialEvents: ->
    if @collection.mode is "infinite"
      @listenTo @collection.fullCollection, "add", @addChildView, @
      @listenTo @collection.fullCollection, "remove", @removeItemView, @
      @listenTo @collection.fullCollection, "reset", @render, @
    else
      super

  onRender: ->
    @isLoading = false

  scrollHandler: _.throttle ->
    $window = $(window)
    buffer = 200
    bottomOfViewport = $window.scrollTop() + $window.height()
    bottomOfCollectionView = @$el.offset().top + @$el.height() - buffer
    if not @isLoading and bottomOfViewport > bottomOfCollectionView
      if @collection.hasNext()
        @isLoading = true
        @collection.getNextPage
          fetch: true
          success: => @isLoading = false
  , 300

  close: ->
    return if @isClosed
    super
    $(window).off "scroll", @scrollHandler

class Index.ListView extends Marionette.Layout

  template: "updates/list"
  regions:
    noteEditorRegion: ".note-editor"
    updatesRegion: ".updates-container"

  constructor: (options) ->
    super options
    @handler = _.bind @refresh, @
    Toruzou.Note.Common.on "note:saved note:deleted", @handler

  onShow: ->
    @noteEditorRegion.show new Toruzou.Note.New.View model: @model
    @updatesRegion.show new Index.CollectionView collection: @collection

  refresh: ->
    @collection.getPage 1,
      fetch: true
      success: => @updatesRegion.currentView.render() if @updatesRegion and @updatesRegion.currentView
        
  close: ->
    return if @isClosed
    super
    Toruzou.Note.Common.off "note:saved", @handler

