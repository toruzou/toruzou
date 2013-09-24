Toruzou.addInitializer ->

  Backbone.PageableCollection::parseLinks = (resp, options) ->
    links = {}
    if resp and resp[0]
      # FIXME
      for key in [ "first", "prev", "next", "last" ]
        base = (_.result @, "url") + "?" + $.param(options.data)
        page_param = "#{key}_page"
        links[key] = base.replace(/page=\d+/, "page=#{resp[0][page_param]}") if resp[0][page_param]
    links