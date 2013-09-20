Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  DROPZONE_MAX_FILE_SIZE_IN_MB = 30
  DROPZONE_MESSAGE = "<i class=\"icon-cloud-upload icon-inline-prefix\"></i>Drag &amp; Drop or Click here to upload files"

  defaultOptions =
    maxFileSize: DROPZONE_MAX_FILE_SIZE_IN_MB
    dictDefaultMessage: DROPZONE_MESSAGE

  Common.dropzone = (options) ->
    sending = options.sending
    options.sending = (file, xhr) ->
      sending file, xhr if sending
      token = $("meta[name=\"csrf-token\"]").attr("content")
      xhr.setRequestHeader "X-CSRF-Token", token if token
    dropzone = new Dropzone options.el, _.extend defaultOptions, options
    dropzone.on "complete", (file) => dropzone.removeAllFiles()
    dropzone
