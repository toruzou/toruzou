Toruzou.module "Organizations.Index", (Index, Toruzou, Backbone, Marionette, $, _) ->

  class Index.GridView extends Toruzou.Common.GridView

    columns: [
      {
        name: "name"
        label: "Name"
        editable: false
        cell: "string"
      }
      {
        name: "abbreviation"
        label: "Abbreviation"
        editable: false
        cell: "string"
      }
      {
        # TODO
        name: "owner"
        label: "Owner"
        editable: false
        cell: "string"
      }
      {
        # TODO
        name: "url"
        label: "Website"
        editable: false
        cell: "string"
      }
    ]
