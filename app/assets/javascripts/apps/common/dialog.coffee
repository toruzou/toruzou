Common = Toruzou.module "Common"

class Common.DialogRegion extends Backbone.Marionette.Region

  onShow: (view) ->
    $modal = @$el.closest("#modal-dialog")
    view.on "close", -> $modal.foundation("reveal", "close")
    $modal.foundation("reveal", "open", closeOnEsc: false)
    $modal.on "opened", -> $modal.foundation("section", "reflow")
    $modal.on "closed", => @close()
    