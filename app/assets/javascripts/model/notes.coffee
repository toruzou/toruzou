Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Note = class Note extends Backbone.Model

  urlRoot: -> if @subject then (_.result @subject, "url") + "/notes" else Model.endpoint "notes"
  modelName: "note"

  constructor: (options) ->
    super options
    @subject = new Toruzou.Model[options.subject_type](options.subject) if options and options.subject and options.subject_type

  defaults:
    message: ""

  schema:
    message:
      type: "TextArea"


Model.Notes = class Notes extends Backbone.PageableCollection

  url: -> if @subject then (_.result @subject, "url") + "/notes" else Model.endpoint "notes"
  model: Model.Note

  state:
    sortKey: "updated_at"
    order: 1


API =
  createNote: (options) ->
    new Model.Note options
  createNotes: (options) ->
    collection = new Model.Notes()
    _.extend collection.queryParams, options
    collection
  getNote: (id) ->
    model = API.createNote id: id
    model.fetch()
  getNotes: (options) ->
    collection = API.createNotes options
    collection.fetch()

Toruzou.reqres.setHandler "note:new", API.createNote
Toruzou.reqres.setHandler "notes:new", API.createNotes
Toruzou.reqres.setHandler "note:fetch", API.getNote
Toruzou.reqres.setHandler "notes:fetch", API.getNotes
