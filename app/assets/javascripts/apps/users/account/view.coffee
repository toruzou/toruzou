Account = Toruzou.module "Users.Account"

class Account.FormView extends Toruzou.Common.FormView

  template: "users/account"
  events:
    "submit form": "save"
    "click .cancel": "cancel"

  save: (e) ->
    e.preventDefault()
    @commit().done (model) =>
      @close()
      @trigger "account:saved", model
        
  cancel: (e) ->
    e.preventDefault()
    @close()


class Account.ChangePasswordView extends Toruzou.Common.FormView

  template: "users/change_password"
  events:
    "submit form": "save"
    "click .cancel": "cancel"

  save: (e) ->
    e.preventDefault()
    @commit().done (model) =>
      @close()
      @trigger "password:saved", model
        
  cancel: (e) ->
    e.preventDefault()
    @close()


class Account.ActionView extends Marionette.ItemView

  template: "users/account_actions"
  events:
    "click #edit-button": "edit"
    "click #change-password-button": "changePassword"

  edit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    editView = new Account.FormView model: new Account.Model.Edit _.clone(@model.attributes)
    editView.on "account:saved", (model) => @triggerMethod "refresh", model
    Toruzou.dialogRegion.show editView

  changePassword: (e) ->
    e.preventDefault()
    e.stopPropagation()
    editView = new Account.ChangePasswordView model: new Account.Model.ChangePassword()
    editView.on "password:saved", (model) => @triggerMethod "refresh", model
    Toruzou.dialogRegion.show editView


class Account.View extends Toruzou.Users.Common.UserView

  template: "users/show"

  navigateToSlug: (slug) ->
    Toruzou.execute "navigate:users:account", slug

  showActions: ->
    view = new Account.ActionView model: @model
    view.on "refresh", (model) => @refresh model
    @actionsRegion.show view
