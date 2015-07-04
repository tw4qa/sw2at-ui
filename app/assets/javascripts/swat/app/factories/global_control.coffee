angular.module("SWAT").factory "GlobalControl", ($cookies)->
  class GlobalControl
    constructor: ->
      @initStatus()
      @setReloader(->{})

    initStatus: ->
      status = $cookies.get('MainMenuStatus') || 'closed';
      @setStatus(status)

    toggle: ->
      @setStatus(if @status == 'closed' then 'opened' else 'closed')

    setStatus: (value)->
      $cookies.put('MainMenuStatus', value);
      @status = value

    setReloader: (func)->
      @reloader = func

    reload: ->
      @reloader()

