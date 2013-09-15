Toruzou.module "People.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

    defaults:
      name: ""
      organizationName: ""
      phone: ""
      email: ""
      ownerName: ""

    schema:
      name:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Name"
      organizationName:
        title: "Organization"
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Organization"
      phone:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Phone"
      email:
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Email"
      ownerName:
        title: "Owner"
        type: "Text"
        editorAttrs:
          placeholder: "Filter by Owner"

  class Index.FilterView extends Toruzou.Common.FilterView

    template: "people/filter"
    events:
      "keyup .filter-item": "filterChanged"

    constructor: (options) ->
      options.model or= new Index.FilteringCondition()
      super options

    filterChanged: _.debounce ->
      @updateModel()
      @triggerMethod "people:filterChanged", @model.apply @collection
    , 200
