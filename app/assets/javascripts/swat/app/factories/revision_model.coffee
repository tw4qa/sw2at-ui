angular.module("SWAT").factory "RevisionModel", ->
  class RevisionModel
    constructor: (@data) ->
      @prepareThreads()
      @info =
        status: @getStatus()

    getStatus: ->
      'perfect'

    prepareThreads: ->
      for thread in @data.threads
        thread.result = _.select(@data.results, (r)-> r.thread_id == thread.thread_id)
        thread.status = 'cool'


angular.module("SWAT").factory "RevisionModelFactory", (RevisionModel, GlResponse)->
  (jsonResponse)->
    object = new GlResponse(jsonResponse)
    if _.isArray(object)
      result = object.map (u)-> new RevisionModel(u)

    else
      result = new RevisionModel(object)
    result

