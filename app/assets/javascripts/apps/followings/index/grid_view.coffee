Index = Toruzou.module "Followings.Index"

class FollowableLinkCell extends Backgrid.Extension.LinkCell

  constructor: (options) ->
    followable = options.model.get "followable"
    options.model = new Toruzou.Model[followable.class_name](followable)
    super options

  href: (rawValue) ->
    route = Toruzou.Configuration.routes[@model.get "class_name"]
    Toruzou.request "route:#{route}:show", @model.get "id"

class Index.GridView extends Toruzou.Common.GridView

  columns: [
    {
      name: "name"
      label: "Name"
      editable: false
      cell: FollowableLinkCell
    }
    {
      name: "updatedAt"
      label: "Followed Datetime"
      editable: false
      cell: "localDatetime"
    }
  ]
