Toruzou.module "Careers.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.ListView extends Marionette.Layout

    template: "careers/list"
    events:
      "click #add-career-button": "addCareer"
    regions:
      gridRegion: "#grid-container"

    constructor: (options) ->
      super options
      @person = options.person

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addCareer: (e) ->
      e.preventDefault()
      e.stopPropagation()
      career = new Toruzou.Models.Career personId: @person.get("id")
      newView = new Toruzou.Careers.New.View model: career
      newView.on "careers:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    refresh: ->
      @collection.fetch()
