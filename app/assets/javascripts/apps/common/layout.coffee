Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class UnauthenticatedLayout extends Marionette.Layout

    template: "layouts/unauthenticated"
    className: "full-screen"

    regions:
      mainRegion: "#unauthenticated-region"

    show: ->
      Toruzou.mainRegion.show @
      @


  class TopbarView extends Marionette.ItemView

    template: "layouts/topbar"


  class ApplicationLayout extends Marionette.Layout

    template: "layouts/application"
    className: "full-screen"

    regions:
      headerRegion: "#header-region"
      mainRegion: "#main-region"

    show: ->
      Toruzou.mainRegion.show @
      @

    onShow: ->
      @headerRegion.show @topbarView or= new TopbarView()
      # FIXME : should be more efficient
      $(document).foundation "off"
      $(document).foundation()


  Common.UnauthenticatedLayout = new UnauthenticatedLayout()
  Common.ApplicationLayout = new ApplicationLayout()  


  class Common.FilteringLayout extends Marionette.Layout

    constructor: (options) ->
      super options
      events = 
        "click .accordion [data-section-title]": "toggleSection"
        "click .filter-item": "toggleFilter"
      events = $.extend true, events, @events if @events
      @delegateEvents events

    toggleSection: (e) ->
      $(e.target).closest("section").toggleClass("active")
      false

    toggleFilter: (e) ->
      $(e.target).closest("li").toggleClass("active")
      false
