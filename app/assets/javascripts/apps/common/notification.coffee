Toruzou.module "Common.Helpers", (Helpers, Toruzou, Backbone, Marionette, $, _) ->

  class Helpers.Notification

    @notification: (type, options) ->
      JST["common/notification"]
        type: type
        title: options.title
        message: options.message
        messages: options.messages

    @success: (options) ->
      @notification "success", options

    @error: (options) ->
      @notification "error", options

    @clear: (el) ->
      el.find(".notification-#{type}").remove() for type in [ "success", "error" ]
