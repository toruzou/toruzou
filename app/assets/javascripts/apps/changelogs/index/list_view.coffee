Index = Toruzou.module "Changelogs.Index"

class Index.ListView extends Marionette.Layout

  template: "changelogs/list"
  regions:
    noteEditorRegion: ".note-editor"
    changelogsRegsion: ".changelogs-container"

  constructor: (options) ->
    super options
    @handler = _.bind @refresh, @
    Toruzou.Note.Common.on "note:saved note:deleted", @handler

  onShow: ->
    @noteEditorRegion.show new Toruzou.Note.New.View model: @model
    @changelogsRegsion.show new Toruzou.Updates.Index.CollectionView collection: @collection

  refresh: ->
    @collection.getPage 1,
      fetch: true
      success: => @changelogsRegsion.currentView.render() if @changelogsRegsion and @changelogsRegsion.currentView
        
  close: ->
    return if @isClosed
    super
    Toruzou.Note.Common.off "note:saved", @handler
