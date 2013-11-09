View = Toruzou.module "Errors.View"

class ErrorView extends Marionette.ItemView

  events:
    "click .redirect": "redirect"

  redirect: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.location ""

class View.NotFoundView extends ErrorView

  template: "errors/not_found"
  events:
    "click .redirect": "redirect"

  redirect: (e) ->
    e.preventDefault()
    e.stopPropagation()
    Toruzou.location ""

class View.ForbiddenView extends ErrorView

  template: "errors/forbidden"

class View.UnknownErrorView extends ErrorView

  template: "errors/unknown_error"
  