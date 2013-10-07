Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

    defaults:
      name: ""
      abbreviation: ""
      ownerName: ""
      includeDeleted: false

    schema:
      name:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Name"
      abbreviation:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Abbreviation"
      ownerName:
        title: "Owner"
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Owner"
      includeDeleted:
        type: "Checkbox"
        editorAttrs:
          placeholder: "Include Deleted"

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "organizations/filter"
    events:
      "keyup .filter-item": "filterChanged"
      "change .filter-item": "filterChanged"

    constructor: (options) ->
      options.model or= new Index.FilteringCondition()
      super options

    filterChanged: _.debounce ->
      @updateModel()
      @triggerMethod "organizations:filterChanged", @model.apply @collection
    , 200
