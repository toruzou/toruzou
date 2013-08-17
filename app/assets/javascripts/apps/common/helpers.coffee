Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.Helpers

    @alert: (type, message) ->
      JST["common/alert"]
        type: type
        message: message

    @success: (message) ->
      @alert "success", message

    @error: (message) ->
      @alert "error", message