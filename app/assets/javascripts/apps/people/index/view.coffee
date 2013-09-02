Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.View extends Toruzou.Common.FilteringLayout

    template: "people/index"
    events:
      "click #add-person-button": "addOrganization"
      "keyup #filter-name": "filterChanged"
      "keyup #filter-organization": "filterChanged"
      "keyup #filter-phone": "filterChanged"
      "keyup #filter-email": "filterChanged"
      "keyup #filter-department": "filterChanged"
      "keyup #filter-title": "filterChanged"
      "keyup #filter-owner": "filterChanged"
    regions:
      gridRegion: "#grid-container"

    onShow: ->
      @gridRegion.show new Index.GridView collection: @collection

    addOrganization: (e) ->
      e.preventDefault()
      e.stopPropagation()
      newView = new Toruzou.People.New.View()
      newView.on "people:saved", => @refresh()
      Toruzou.dialogRegion.show newView

    filterChanged: _.debounce ->
      @collection.queryParams["name"] = @$el.find("#filter-name").val()
      @collection.queryParams["organization_name"] = @$el.find("#filter-organization").val()
      @collection.queryParams["phone"] = @$el.find("#filter-phone").val()
      @collection.queryParams["email"] = @$el.find("#filter-email").val()
      @collection.queryParams["department"] = @$el.find("#filter-department").val()
      @collection.queryParams["title"] = @$el.find("#filter-title").val()
      @collection.queryParams["owner_name"] = @$el.find("#filter-owner").val()
      @refresh()
    , 200

    refresh: ->
      @collection.fetch()
