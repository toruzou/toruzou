Toruzou.module "Deals.Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FormView extends Toruzou.Common.FormView

    template: "deals/form"
    events:
      "submit form": "save"
      "click .cancel": "cancel"
    schema:
      name:
        editorAttrs:
          placeholder: "Name"
      organizationId:
        editorAttrs:
          placeholder: "Organization"
      contactId:
        editorAttrs:
          placeholder: "Contact"
      pmId:
        editorAttrs:
          placeholder: "Project Manager"
      salesId:
        editorAttrs:
          placeholder: "Sales Person"
      status:
        editorAttrs:
          placeholder: "Status"
      amount:
        editorAttrs:
          placeholder: "Amount"
      accuracy:
        editorAttrs:
          placeholder: "Accuracy"
      startDate:
        editorAttrs:
          placeholder: "Start Date"
      orderDate:
        editorAttrs:
          placeholder: "Order Date"
      acceptDate:
        editorAttrs:
          placeholder: "Accept Date"

    constructor: (options) ->
      super options
      @title = _.result options, "title"

    serializeData: ->
      data = super
      data["title"] = @title
      data

    save: (e) ->
      e.preventDefault()
      @commit
        success: (model, response) =>
          @close()
          @triggerMethod "deals:saved"
          
    cancel: (e) ->
      e.preventDefault()
      @close()
