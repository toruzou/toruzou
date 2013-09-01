Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Toruzou.Common.FilteringLayout

    template: "organizations/index"
    events:
      "click #add-organization-button": "addOrganization"
      "keyup #filter-name": "filterChanged"
      "keyup #filter-abbreviation": "filterChanged"
      "keyup #filter-owner-name": "filterChanged"
    regions:
      gridRegion: "#grid-container"

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.Organizations.New.View()
      newView.on "organizations:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    filterChanged: _.debounce ->
      @collection.queryParams["name"] = @$el.find("#filter-name").val()
      @collection.queryParams["abbreviation"] = @$el.find("#filter-abbreviation").val()
      @collection.queryParams["owner_name"] = @$el.find("#filter-owner-name").val()
      @refresh()
    , 200

    refresh: ->
      @collection.fetch()
