Toruzou.module "Activities.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "activities/filter"

    filterChanged: _.debounce ->
      # TODO
      @triggerMethod "activities:filterChanged", @collection
    , 200
