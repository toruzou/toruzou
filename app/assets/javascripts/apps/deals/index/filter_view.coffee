Index = Toruzou.module "Deals.Index"

class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

  defaults:
    name: ""
    organizationName: ""
    contactName: ""
    pmName: ""
    salesName: ""
    statuses: []
    includeDeleted: false

  schema:
    name:
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Name"
    projectTypes:
      type: "Selectize"
      options: Toruzou.Model.Deal::projectTypes
      selectize:
        maxItems: Toruzou.Model.Deal::projectTypes.length
      editorAttrs:
        placeholder: "Filter by Project types"
    categories:
      type: "Selectize"
      options: Toruzou.Model.Deal::categories
      selectize:
        maxItems: Toruzou.Model.Deal::categories.length
      editorAttrs:
        placeholder: "Filter by Categories"
    organizationName:
      title: "Client Organization"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Client Organization"
    contactName:
      title: "Client Person"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Client Person"
    pmName:
      title: "Project Manager"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Project Manager"
    salesName:
      title: "Sales Person"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Sales Person"
    includeDeleted:
      type: "Checkbox"
      editorAttrs:
        placeholder: "Include Deleted"

class Index.FilterView extends Toruzou.Common.FilterView

  template: "deals/filter"
  events:
    "keyup .filter-item": "filterChanged"
    "change .filter-item": "filterChanged"

  constructor: (options) ->
    options.model or= new Index.FilteringCondition()
    super options

  filterChanged: _.debounce ->
    @updateModel()
    @triggerMethod "deals:filterChanged", @model.apply @collection
  , 200
  
