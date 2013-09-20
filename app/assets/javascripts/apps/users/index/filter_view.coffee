Toruzou.module "Users.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

    defaults:
      name: ""
      email: ""

    schema:
      name:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Name"
      email:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Email"

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "users/filter"
    events:
      "keyup .filter-item": "filterChanged"

    constructor: (options) ->
      options.model or= new Index.FilteringCondition()
      super options

    filterChanged: _.debounce ->
      @updateModel()
      @triggerMethod "users:filterChanged", @model.apply @collection
    , 200
