Header = Toruzou.module "Header"

class Header.View extends Marionette.ItemView

  template: "layouts/header"
  events:
    "click #signOut-button": "signOut"

  signOut: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.when(Toruzou.request "signOut").done -> Toruzou.location ""

Header.API =
  show: ->
    view = new Header.View()
    Toruzou.headerRegion.show view
    view.$el.foundation()
  hide: ->
    if Toruzou.headerRegion.currentView instanceof Header.View
      Toruzou.headerRegion.currentView.$el.foundation "off"
      Toruzou.headerRegion.close()

Toruzou.commands.setHandler "layout:application:header:show", Header.API.show
Toruzou.commands.setHandler "layout:application:header:hide", Header.API.hide
