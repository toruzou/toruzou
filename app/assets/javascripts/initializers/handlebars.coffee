Toruzou.addInitializer ->

  Handlebars.registerHelper "relativeUrl", (relative, key) ->
    path = relative
    path += "/#{key}" if key
    Toruzou.linkTo path

  # TODO duplicated, should refactor

  Handlebars.registerHelper "amount", (value) ->
    return "" unless value
    values = value.toString().split "."
    integral = values[0]
    integral = integral.replace /\B(?=(\d{3})+(?!\d))/g, ","
    decimal = if values[1] then ".#{values[1]}" else ""
    integral + decimal

  Handlebars.registerHelper "percent", (value) ->
    return "" unless value
    "#{value} %"

  Handlebars.registerHelper "localDate", (value) ->
    return "" unless value
    if /\d{4}-\d{2}-\d{2}/.test(value) then value.replace(/-/g, "/") else ""
