Common = Toruzou.module "Common"

class Common.FilteringCondition extends Backbone.Model

  apply: (collection) ->
    context = @toJSON()
    throw "Unexpected Collection" unless collection instanceof Backbone.PageableCollection
    extraQueryParams = _.omit context, (_.keys Backbone.PageableCollection::queryParams)
    _.extend collection.queryParams, extraQueryParams
    collection
    