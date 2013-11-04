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
    organizationName:
      title: "Organization"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Organization"
    contactName:
      title: "Contact Person"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Contact Person"
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
    statuses:
      type: "Selectize"
      options: Toruzou.Model.Deal::statuses
      selectize:
        maxItems: Toruzou.Model.Deal::statuses.length
      editorAttrs:
        placeholder: "Filter by Statuses"
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
  