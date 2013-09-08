Toruzou.module "Deals.Show", (Show, Toruzou, Backbone, Marionette, $, _) ->

  class Show.View extends Marionette.ItemView

    template: "deals/show"
    events:
      "click #edit-button": "edit"
      "click #delete-button": "delete"
      "click [data-section-title]": "sectionChanged"

    sectionChanged: (e) ->
      $section = $(e.target).closest("section")
      @show $section.attr "id"

    show: (slug) ->
      return unless slug
      _.each @$el.find("section"), (section) -> $(section).removeClass "active"
      @$el.find("##{slug}").addClass "active"
      # TODO switch slug
      Toruzou.trigger "deal:sectionChanged", id: @model.get("id"), slug: slug

    onRender: ->
      @$el.foundation("section", "reflow")
      
    edit: (e) ->
      e.preventDefault()
      e.stopPropagation()
      editView = new Toruzou.Deals.Edit.View model: @model
      editView.on "deals:saved", => @render()
      Toruzou.dialogRegion.show editView

    delete: (e) ->
      e.preventDefault()
      e.stopPropagation()
      @model.destroy success: (model, response) -> Toruzou.trigger "deals:list"
