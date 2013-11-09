Show = Toruzou.module "Users.Show"

class Show.ActionView extends Marionette.ItemView

  template: "users/show_actions"
  events:
    "click #follow-button": "follow"
    "click #unfollow-button": "unfollow"

  follow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("user:follow", @model.get "id").done (model) => @triggerMethod "refresh", model

  unfollow: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.request("user:unfollow", @model.get "id").done (model) => @triggerMethod "refresh", model


class Show.View extends Toruzou.Users.Common.UserView

  template: "users/show"

  showActions: ->
    view = new Show.ActionView model: @model
    view.on "refresh", (model) => @refresh model
    @actionsRegion.show view
