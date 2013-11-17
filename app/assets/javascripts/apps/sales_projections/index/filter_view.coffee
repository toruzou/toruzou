Index = Toruzou.module "SalesProjections.Index"

class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

  defaults:
    organizationName: ""
    dealName: ""
    from: undefined
    to: undefined

  schema:
    organizationName:
      title: "Organization"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Organization"
    dealName:
      title: "Deal"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Deal"
    from:
      title: "Fiscal Year (From)"
      type: "PositiveInteger"
      editorAttrs:
        placeholder: "Filter by Fiscal year (from)"
    to:
      title: "Fiscal Year (To)"
      type: "PositiveInteger"
      editorAttrs:
        placeholder: "Filter by Fiscal year (to)"

class Index.FilterView extends Toruzou.Common.FilterView

  template: "sales_projections/filter"
  events:
    "keyup .filter-item": "filterChanged"
    "change .filter-item": "filterChanged"

  constructor: (options) ->
    options.model or= new Index.FilteringCondition()
    super options

  filterChanged: _.debounce ->
    @updateModel()
    @triggerMethod "salesProjections:filterChanged", @model.apply @collection
  , 200
