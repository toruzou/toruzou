Toruzou.module "Common", (Common, Toruzou, Backbone, Marionette, $, _) ->

  class Common.FilterView extends Marionette.ItemView

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
      $element = $(e.target)
      $ul = $element.closest "ul"
      _.each $ul.find("li.filter-item"), (item) -> $(item).removeClass "active" unless _.isUndefined($ul.data "selection-single")
      $(e.target).closest("li").toggleClass("active")
      false
