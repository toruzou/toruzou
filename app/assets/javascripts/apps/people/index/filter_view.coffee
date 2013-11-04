Index = Toruzou.module "People.Index"

class Index.FilteringCondition extends Toruzou.Common.FilteringCondition

  defaults:
    name: ""
    organizationName: ""
    phone: ""
    email: ""
    ownerName: ""
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
    includeDeleted:
      type: "Checkbox"
      editorAttrs:
        placeholder: "Include Deleted"

class Index.FilterView extends Toruzou.Common.FilterView

  template: "people/filter"
  events:
    "keyup .filter-item": "filterChanged"
    "change .filter-item": "filterChanged"

  constructor: (options) ->
    options.model or= new Index.FilteringCondition()
    super options

  filterChanged: _.debounce ->
    @updateModel()
    @triggerMethod "people:filterChanged", @model.apply @collection
  , 200
