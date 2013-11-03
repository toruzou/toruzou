Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Note = class Note extends Backbone.Model

    urlRoot: -> if @subject then (_.result @subject, "url") + "/notes" else Models.endpoint "notes"
    modelName: "note"

    constructor: (options) ->
      super options
      @subject = new Toruzou.Models[options.subject_type](options.subject) if options and options.subject and options.subject_type

    defaults:
      message: ""

    schema:
      message:
        type: "TextArea"


  Models.Notes = class Notes extends Backbone.PageableCollection

    url: -> if @subject then (_.result @subject, "url") + "/notes" else Models.endpoint "notes"
    model: Models.Note

    state:
      sortKey: "updated_at"
      order: 1


  API =
    getNotes: (options) ->
      notes = new Models.Notes()
      _.extend notes.queryParams, options
      dfd = $.Deferred()
      notes.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getNote: (id) ->
      note = new Models.Note id: id
      dfd = $.Deferred()
      note.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "notes:fetch", (options) -> API.getNotes options
  Toruzou.reqres.setHandler "note:fetch", (id) -> API.getNote id
