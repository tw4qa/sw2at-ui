angular.module("SWAT").factory "RevisionModel", ->
  class RevisionModel
    constructor: (@data) ->
      @prepareThreads()
      console.log(@data)

    prepareThreads: ->
      for thread in @data.threads
        thread.tests = @data.tests[thread.thread_id] if @data.tests

angular.module("SWAT").factory "RevisionModelFactory", (RevisionModel, GlResponse)->
  (jsonResponse)->
    object = new GlResponse(jsonResponse)
    if _.isArray(object)
      result = object.map (u)-> new RevisionModel(u)

    else
      result = new RevisionModel(object)
    result

