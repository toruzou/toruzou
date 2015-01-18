Index = Toruzou.module "SalesProjections.Index"

class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

  defaults:
    organizationName: ""
    dealName: ""
    from: undefined
    to: undefined

  schema:
    organizationName:
      title: "Client Organization"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Client Organization"
    dealName:
      title: "Deal"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Deal"
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
        placeholder: "Filter by Deal categories"
    statuses:
      type: "Selectize"
      options: Toruzou.Model.SalesProjection::statuses
      selectize:
        maxItems: Toruzou.Model.SalesProjection::statuses.length
      editorAttrs:
        placeholder: "Filter by Deal statuses"
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
