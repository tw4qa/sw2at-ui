angular.module("SWAT").factory "GlobalControl", ($cookies)->
  class GlobalControl

    constructor: ->
      @COOKIE_KEY = 'MainMenuStatus'
      @COOKIE_OPTS = { path: '/swat' }
      @OPENED = 'opened'
      @CLOSED = 'closed'
      @initStatus()
      @setReloader(->{})

    initStatus: ->
      status = $cookies.get(@COOKIE_KEY, @COOKIE_OPTS);
      @setStatus(status || @CLOSED)

    toggle: ->
      @setStatus(if @status == @CLOSED then @OPENED else @CLOSED)

    setStatus: (value)->
      $cookies.put(@COOKIE_KEY, value, @COOKIE_OPTS);
      @status = value

    setReloader: (func)->
      @reloader = func

    reload: ->
      @promise = @reloader()

    isLoading: ->
      @promise && @promise.$promise && !@promise.$resolved

