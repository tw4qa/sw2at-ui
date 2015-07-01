angular.module("SWAT").factory "RevisionModel", ->
  class RevisionModel
    constructor: (@data) ->
      window.Swat.log(@data)

angular.module("SWAT").factory "RevisionModelFactory", (RevisionModel, GlResponse)->
  (jsonResponse)->
    object = new GlResponse(jsonResponse)
    if _.isArray(object)
      result = object.map (u)-> new RevisionModel(u)

    else
      result = new RevisionModel(object)
    result

