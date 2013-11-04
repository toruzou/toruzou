Model = Toruzou.module "Model"

# TODO Refine validators (character length etc.)

Model.Activity = class Activity extends Backbone.Model

  urlRoot: Model.endpoint "activities"
  modelName: "activity"
  actions: [
    "Meeting"
    "Call"
    "Email"
    "Task"
  ]
  icons:
    "Meeting": "briefcase"
    "Email": "envelope"
    "Call": "phone"
    "Task": "ticket"

  defaults:
    subject: ""
    action: ""
    date: ""
    note: ""
    done: false
    organization: null
    organizationId: null
    deal: null
    dealId: null
    users: []
    userIds: []
    people: []
    peopleIds: []

  # TODO ugly, should be moved to view layer
  renderAction: (action) ->
    "<i class='icon-#{Activity::icons[action]} icon-inline-prefix'></i>#{_.escape action}"

  schema:
    subject:
      type: "Text"
      validators: [ "required" ]
    action:
      type: "Selectize"
      validators: [ "required" ]
      restore: (model) ->
        action = model.get "action"
        {
          value: action
          data: action
        }
      options: @::actions
      selectize:
        render:
          option: (item, escape) => "<div>#{Activity::renderAction item.text}</div>"
    date:
      type: "Datepicker"
    organizationId: $.extend true, {},
      Model.Schema.Organization,
      title: "Organization"
      key: "organization"
    dealId: $.extend true, {},
      Model.Schema.Deal,
      title: "Deal"
      key: "deal"
    usersIds: $.extend true, {},
      Model.Schema.Users,
      title: "Users"
      key: "users"
    peopleIds: $.extend true, {},
      Model.Schema.People,
      title: "Contacts"
      key: "people"
    note:
      type: "TextArea"
    done:
      type: "Checkbox"

  attachmentsUrl: ->
    _.result(@, "url") + "/attachments"

  toggleDone: ->
    done = !!!(@get "done")
    @set "done", done
    done


Model.Activities = class Activity extends Backbone.PageableCollection

  url: Model.endpoint "activities"
  model: Model.Activity

  state:
    sortKey: "date"
    order: 1
    

API =
  getActivities: (options) ->
    activities = new Model.Activities()
    _.extend activities.queryParams, options
    dfd = $.Deferred()
    activities.fetch success: (collection) -> dfd.resolve collection
    dfd.promise()
  getActivity: (id) ->
    activity = new Model.Activity id: id
    dfd = $.Deferred()
    activity.fetch
      success: (model) -> dfd.resolve model
      error: (model) -> dfd.resolve undefined
    dfd.promise()

Toruzou.reqres.setHandler "activities:fetch", (options) -> API.getActivities options
Toruzou.reqres.setHandler "activity:fetch", (id) -> API.getActivity id
