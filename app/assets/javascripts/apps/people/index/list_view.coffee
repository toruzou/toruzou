Index = Toruzou.module "People.Index"

class Index.ListView extends Marionette.Layout

  template: "people/list"
  events:
    "click #add-person-button": "addPerson"
  regions:
    gridRegion: "#grid-container"

  constructor: (options) ->
    super options
    @organization = options?.organization

  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection

  addPerson: (e) ->
    e.preventDefault()
    e.stopPropagation()
    person = Toruzou.request "person:new"
    person.set "organization", @organization if @organization
    newView = new Toruzou.People.New.View model: person
    newView.on "person:saved", => @refresh()
    Toruzou.dialogRegion.show newView

  refresh: ->
    @collection.fetch()
