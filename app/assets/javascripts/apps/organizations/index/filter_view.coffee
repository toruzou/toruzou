Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "organizations/filter"
    events:
      "keyup input[data-filter]": "filterChanged"

    filterChanged: _.debounce ->
      _.each @$el.find("input[data-filter]"), (item) =>
        $item = $(item)
        @collection.queryParams[$item.data("filter")] = $item.val()
      @triggerMethod "organizations:filterChanged", @collection
    , 200
