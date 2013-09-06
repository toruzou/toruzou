Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "people/list"
    events:
      "click #add-person-button": "addPerson"
    regions:
      gridRegion: "#grid-container"

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addPerson: (e) ->
      e.preventDefault()
      e.stopPropagation()
      person = new Toruzou.Models.Person()
      person.set "organization", @options.organization if @options.organization
      newView = new Toruzou.People.New.View model: person
      newView.on "people:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
