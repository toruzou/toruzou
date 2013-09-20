Toruzou.module "Attachments", (Attachments, Toruzou, Backbone, Marionette, $, _) ->

  class Attachments.View extends Marionette.Layout

    template: "attachments/index"
    regions:
      gridRegion: ".attachments-grid-container"

    constructor: (options) ->
      super options
      @fetchingOptions = options.fetch
      @dropzoneOptions = options.dropzone

    onShow: ->
      $.when(Toruzou.request "attachments:fetch", @fetchingOptions).done (attachments) =>
        @gridRegion.show new Attachments.GridView collection: attachments
        @dropzone = Toruzou.Common.dropzone _.extend { el: @$el.find(".dropzone")[0] }, @dropzoneOptions
        @dropzone.on "complete", => attachments.fetch()

    close: ->
      return if @isClosed
      super
      @dropzone.disable()
