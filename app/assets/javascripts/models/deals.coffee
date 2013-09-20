Toruzou.module "Models", (Models, Toruzou, Backbone, Marionette, $, _) ->

  # TODO Refine validators (character length etc.)

  Models.Deal = class Deal extends Backbone.Model

    urlRoot: Models.endpoint "deals"
    modelName: "deal"
    statuses: [
      "Plan"
      "Proposal"
      "In Negotiation"
    ]

    defaults:
      name: ""
      organization: null
      organizationId: null
      pm: null
      pmId: null
      sales: null
      salesId: null
      contact: null
      contactId: null
      status: ""
      amount: null
      accuracy: null
      startDate: ""
      orderDate: ""
      acceptDate: ""
      
    schema:
      name:
        type: "Text"
        validators: [ "required" ]
      organizationId: $.extend true, {},
        Models.Schema.Organization,
        title: "Organization"
        key: "organization"
      pmId: $.extend true, {},
        Models.Schema.User,
        title: "Project Manager"
        key: "pm"
      salesId: $.extend true, {},
        Models.Schema.User,
        title: "Sales Person"
        key: "sales"
      contactId: $.extend true, {},
        Models.Schema.Person,
        title: "Contact Person"
        key: "contact"
      status:
        type: "Selectize"
        restore: (model) ->
          status = model.get "status"
          {
            value: status
            data: status
          }
        options: @::statuses
      amount:
        type: "PositiveAmount"
      accuracy:
        type: "PositivePercentInteger"
        validators: [
          (value, formValues) ->
            return { message: "Invalid accuracy" } if value and value > 100
        ]
      startDate:
        type: "Datepicker"
      orderDate:
        type: "Datepicker"
      acceptDate:
        type: "Datepicker"

    attachmentsUrl: ->
      _.result(@, "url") + "/attachments"
      

  Models.Deals = class Deal extends Backbone.PageableCollection

    url: Models.endpoint "deals"
    model: Models.Deal


  API =
    getDeals: (options) ->
      deals = new Models.Deals()
      _.extend deals.queryParams, options
      dfd = $.Deferred()
      deals.fetch success: (collection) -> dfd.resolve collection
      dfd.promise()
    getDeal: (id) ->
      deal = new Models.Deal id: id
      dfd = $.Deferred()
      deal.fetch
        success: (model) -> dfd.resolve model
        error: (model) -> dfd.resolve undefined
      dfd.promise()

  Toruzou.reqres.setHandler "deals:fetch", (options) -> API.getDeals options
  Toruzou.reqres.setHandler "deal:fetch", (id) -> API.getDeal id