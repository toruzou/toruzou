Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "organizations/filter"
    events:
      "keyup #filter-name": "filterChanged"
      "keyup #filter-abbreviation": "filterChanged"
      "keyup #filter-owner": "filterChanged"

    filterChanged: _.debounce ->
      @collection.queryParams["name"] = @$el.find("#filter-name").val()
      @collection.queryParams["abbreviation"] = @$el.find("#filter-abbreviation").val()
      @collection.queryParams["owner_name"] = @$el.find("#filter-owner").val()
      @triggerMethod "organizations:filterChanged", @collection
    , 200
