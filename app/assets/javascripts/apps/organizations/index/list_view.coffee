Index = Toruzou.module "Organizations.Index"

class Index.ListView extends Marionette.Layout

  template: "organizations/list"
  events:
    "click #add-organization-button": "addOrganization"
  regions:
    gridRegion: "#grid-container"

  constructor: (options) ->
    super options
    @owner = options?.owner

  onShow: ->
    @gridRegion.show new Index.GridView collection: @collection

  addOrganization: (e) ->
    e.preventDefault()
    e.stopPropagation()
    organization = Toruzou.request "organization:new"
    organization.set "owner", @owner if @owner
    newView = new Toruzou.Organizations.New.View model: organization
    newView.on "organization:saved", => @refresh()
    Toruzou.dialogRegion.show newView

  refresh: ->
    @collection.fetch()
