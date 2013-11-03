Toruzou.addInitializer ->

  Handlebars.registerHelper "match", (v1, operator, v2, options) ->
    switch operator
      when "eq"
        if v1 is v2 then options.fn @ else options.inverse @
      when "ne"
        if v1 isnt v2 then options.fn @ else options.inverse @
      when "lt"
        if v1 < v2 then options.fn @ else options.inverse @
      when "le"
        if v1 <= v2 then options.fn @ else options.inverse @
      when "gt"
        if v1 > v2 then options.fn @ else options.inverse @
      when "ge"
        if v1 >= v2 then options.fn @ else options.inverse @
      else
        options.inverse @

  Handlebars.registerHelper "relativeUrl", (relative, key) ->
    path = relative
    path += "/#{key}" if key
    Toruzou.linkTo path

  _.each [
    "amount"
    "percent"
    "localDate"
    "localDatetime"
  ], (format) -> Handlebars.registerHelper format, (value) -> Toruzou.Common.Formatters[format] value
