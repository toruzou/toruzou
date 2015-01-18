Common = Toruzou.module "SalesProjections.Common"

class Common.FormView extends Toruzou.Common.FormView

  template: "sales_projections/form"
  events:
    "submit form": "save"
    "click .cancel": "cancel"
  schema:
    dealId:
      editorAttrs:
        placeholder: "Deal"
    year:
      editorAttrs:
        placeholder: "Fiscal Year"
    period:
      editorAttrs:
        placeholder: "Period"
    amount:
      editorAttrs:
        placeholder: "Amount"
    startDate:
      editorAttrs:
        placeholder: "Start Date"
    endDate:
      editorAttrs:
        placeholder: "End Date"
    orderDate:
      editorAttrs:
        placeholder: "Order Date"
    profitAmount:
      editorAttrs:
        placeholder: "Profit"
    profitRate:
      editorAttrs:
        placeholder: "Profit Rate"
    obicNo:
      editorAttrs:
        placeholder: "OBIC No."
    remarks:
      editorAttrs:
        placeholder: "Remarks"

  constructor: (options) ->
    super options
    @title = _.result options, "title"
    @dialog = options.dialog

  serializeData: ->
    data = super
    data["title"] = @title if @title
    data

  save: (e) ->
    e.preventDefault()
    @commit().done (model) =>
      Toruzou.SalesProjections.trigger "salesProjection:saved"
      @close()
        
  cancel: (e) ->
    e.preventDefault()
    @close()
