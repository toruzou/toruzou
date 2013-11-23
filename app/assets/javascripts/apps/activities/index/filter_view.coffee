Index = Toruzou.module "Activities.Index"

terms = [
  "Overdue"
  "Last Week"
  "Today"
  "Tomorrow"
  "This Week"
  "Next Week"
]
statuses = [
  { label: "Complete", val: "true" }
  { label: "Incomplete", val: "false" }
]

class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

  defaults:
    name: ""
    actions: undefined
    dealName: ""
    organizationName: ""
    term: ""
    status: []
    includeDeleted: false

  schema:
    name:
      title: "Subject"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Subject"
    actions:
      type: "Selectize"
      options: Toruzou.Model.Activity::actions
      selectize:
        maxItems: Toruzou.Model.Activity::actions.length
      editorAttrs:
        placeholder: "Filter by Actions"
    dealName:
      title: "Deal"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Deal"
    organizationName:
      title: "Client Organization"
      type: "Text"
      editorAttrs:
        placeholder: "Filter by Client Organization"
    term:
      type: "Selectize"
      options: terms
      editorAttrs:
        placeholder: "Filter by Term"
    status:
      type: "Selectize"
      options: statuses
      editorAttrs:
        placeholder: "Filter by Status"
    includeDeleted:
      type: "Checkbox"
      editorAttrs:
        placeholder: "Include Deleted"

class Index.FilterView extends Toruzou.Common.FilterView

  template: "activities/filter"
  events:
    "keyup .filter-item": "filterChanged"
    "change .filter-item": "filterChanged"

  constructor: (options) ->
    options.model or= new Index.FilteringCondition()
    super options

  filterChanged: _.debounce ->
    @updateModel()
    @triggerMethod "activities:filterChanged", @model.apply @collection
  , 200
