Toruzou.addInitializer ->

  Handlebars.registerHelper "option", (type, value) ->
    Toruzou.Common.Formatters.option type, value

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

  Handlebars.registerHelper "route", (path, params...) ->
    params.pop()
    Toruzou.request "route:#{path}", params...

  Handlebars.registerHelper "linkTo", (name, path, params...) ->
    params.pop()
    Toruzou.request "linkTo:#{path}", name, params...

  _.each [
    "amount"
    "percent"
    "localDate"
    "localDatetime"
  ], (format) -> Handlebars.registerHelper format, (value) -> Toruzou.Common.Formatters[format] value
