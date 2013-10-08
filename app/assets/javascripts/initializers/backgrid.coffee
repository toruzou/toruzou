Toruzou.addInitializer ->

  sort = Backgrid.HeaderCell::sort
  Backgrid.HeaderCell::sort = (columnName, direction, comparator) ->
    sort.call @, _.str.underscored(columnName), direction, comparator
