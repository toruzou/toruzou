Toruzou.module "Deals.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "deals/filter"
    events:
      "keyup #filter-name": "filterChanged"
      "keyup #filter-organization": "filterChanged"

    filterChanged: _.debounce ->
      @collection.queryParams["name"] = @$el.find("#filter-name").val()
      @collection.queryParams["organization_name"] = @$el.find("#filter-organization").val()
      @triggerMethod "deals:filterChanged", @collection
    , 200
