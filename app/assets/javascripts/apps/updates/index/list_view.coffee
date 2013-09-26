Toruzou.module "Updates.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

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
      data.subjectRoute = Toruzou.Configuration.routes[data.subjectType]
      data

    activateEditor: (e) ->
      e.preventDefault()
      view = new Toruzou.Note.Common.FormView model: @model
      view.on "editor:commit editor:cancel", @deactivateEditor
      @contentsRegion.show view

    deactivateEditor: ->
      @contentsRegion.show new Index.NoteMessageView model: @model

    deleteNote: (e) ->
      e.preventDefault()
      @model.destroy success: => Toruzou.Note.Common.trigger "note:deleted" # TODO


  class Index.UpdateItemView extends Marionette.Layout

    template: "updates/item"
    regions:
      updateRegion: ".update"

    onShow: ->
      # TODO support other updates
      @updateRegion.show new Index.NoteItemView model: new Toruzou.Models.Note @model.attributes


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
        success: => @updatesRegion.currentView.render()

    close: ->
      return if @isClosed
      super
      Toruzou.Note.Common.off "note:saved", @handler

