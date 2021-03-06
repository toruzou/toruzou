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
    Toruzou.request "note:new", @model.get("auditable")


class Index.ChangeItemView extends Marionette.ItemView

  template: "updates/change"

  # TODO ugly, should refactor
  serializeData: ->
    data = super
    data.action = Toruzou.Configuration.bundles.actions[data.audit.action]
    auditable = data.auditable = new Toruzou.Model[data.audit.auditable.class_name] data.audit.auditable
    data.subjectHeader = @createSubjectHeader auditable, data.audit.action
    changes = data.changes = {}
    serializeChange = (key, change) -> auditable.format key, change
    for key, change of data.audit.changes
      key = _.str.camelize key
      changes[key] =
        propertyName: auditable.displayNameOf key
        before: serializeChange key, change[0]
        after: serializeChange key, change[1]
    data

  # TODO ugly
  createSubjectHeader: (auditable, action) ->
    switch auditable.constructor.name
      when "Deal"
        header = Toruzou.request "linkTo:deals:show", auditable.get("name"), auditable.get("id")
        organization = auditable.get "organization"
        header += " of " + Toruzou.request "linkTo:organizations:show", organization.name, organization.id if organization
        "a deal " + header
      when "Person"
        header = Toruzou.request "linkTo:people:show", auditable.get("name"), auditable.get("id")
        organization = auditable.get "organization"
        header += " of " + Toruzou.request "linkTo:organizations:show", organization.name, organization.id if organization
        "a client member " + header
      when "Organization"
        header = Toruzou.request "linkTo:organizations:show", auditable.get("name"), auditable.get("id")
        "a client organization " + header
      when "User"
        header = Toruzou.request "linkTo:users:show", auditable.get("name"), auditable.get("id")
        "a user " + header
      when "Career"
        person = auditable.get "person"
        header = Toruzou.request "linkTo:people:show", person.name, person.id
        header + "'s career"
      when "SalesProjection"
        deal = auditable.get "deal"
        header = Toruzou.request "linkTo:deals:show", deal.name, deal.id
        header + "'s sales projection"
      when "Attachment"
        header = Toruzou.request "linkTo:attachment:download", auditable.get("name"), auditable.get("id")
        header = "an attachment " + header
        attachable = new Toruzou.Model[auditable.get "attachable_type"] auditable.get "attachable"
        route = Toruzou.Configuration.routes[attachable.constructor.name]
        link = Toruzou.request "linkTo:#{route}:show", attachable.get("name"), attachable.get("id")
        header += " to " + link
      when "Activity"
        header = Toruzou.request "linkTo:activities:show", auditable.get("name"), auditable.get("id")
        header = " an activity " + header
        deal = auditable.get "deal"
        header += " to " + Toruzou.request "linkTo:deals:show", deal.name, deal.id if deal
        organization = auditable.get "organization"
        header += " #{if deal then "of" else "to"} " + Toruzou.request "linkTo:organizations:show", organization.name, organization.id if organization
        people = auditable.get "people"
        header += " with " + (_.map people, (person) -> Toruzou.request "linkTo:people:show", person.name, person.id).join ", " if people and people.length > 0
        header 
      else
        throw new Error "Unexpected auditable"

class Index.UpdateItemView extends Marionette.Layout

  template: "updates/item"
  regions:
    updateRegion: ".update"

  onShow: ->
    audit = new Backbone.Model(@model.get "audit")
    auditable = audit.get "auditable"
    view = undefined
    switch auditable.class_name
      when "Note"
        view = new Index.NoteItemView model: audit
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
      if @collection.hasNextPage()
        @isLoading = true
        @collection.getNextPage
          fetch: true
          success: => @isLoading = false
  , 300

  close: ->
    return if @isClosed
    super
    $(window).off "scroll", @scrollHandler
