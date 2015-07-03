angular.module("SWAT").factory "GlobalControl", ->
  class GlobalControl
    constructor: ->
      @initStatus()
      @setReloader(->{})

    initStatus: ->
      @setStatus('closed')

    toggle: ->
      @setStatus(if @status == 'closed' then 'opened' else 'closed')

    setStatus: (value)->
      @status = value

    setReloader: (func)->
      @reloader = func

    reload: ->
      @reloader()

