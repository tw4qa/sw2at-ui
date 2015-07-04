angular.module("SWAT").factory "ExceptionGroups", ->
  class ExceptionGroups
    constructor: (@fails)->

    data: ->
      groups = _.groupBy(@fails, (f)->(f.exception.message) )
      window.Swat.log(groups)

      result = []
      for exMessage in _.keys(groups)
        exception =
          message: exMessage
          backtrace: groups[exMessage][0].exception.backtrace
          tests: groups[exMessage]
        result.push(exception)
      window.Swat.log(result)
      result