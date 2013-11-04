Helpers = Toruzou.module "Common.Helpers"

Helpers.parseJSON = (response) ->
  return null unless response
  if response.getResponseHeader("content-type").match /^(application\/json|text\/javascript)/
    try
      return ($.parseJSON || JSON.parse) response.responseText
    catch e
      # FIXME
  null
